Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E04C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C17222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arnyOO6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C17222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsv2-0006Ib-Cs
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kQssy-0004K0-0O
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kQssu-0002ao-OA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602251796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c49QWObKbunjYuR7UeJ3p2nHA9YKNtmsllsR8gOUI9U=;
 b=arnyOO6Lzh+egMx42lfiJBdL1RBIVG4fQzDZZJ39aRy8l7/RJToVsiu67MYDmKRC0dOpfC
 K/XlAb8qTz1Efhi6+BWPouX5hswdDUsuvEQ8CcLR0V9BU2GyuaMVXWebqccpUAr0CLawEj
 oyvu6nu0XyHfQY5xJ/3GFJUdQLRX3dA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-F1kpCXwMPoazdcGnwX5N-g-1; Fri, 09 Oct 2020 09:56:34 -0400
X-MC-Unique: F1kpCXwMPoazdcGnwX5N-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07714108E1B6;
 Fri,  9 Oct 2020 13:56:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0442D1972B;
 Fri,  9 Oct 2020 13:56:30 +0000 (UTC)
Subject: Re: Which qemu change corresponds to RedHat bug 1655408
To: Jakob Bohm <jb-gnumlists@wisemo.com>
References: <2d9c8525-470f-a4e5-5d71-895046e2d782@wisemo.com>
 <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
 <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
 <0c76d4c9-a203-8bc3-e367-b198efe819d9@redhat.com>
 <7d9328d2-69b6-5bb4-405d-5756e14688ec@wisemo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <81886f9a-91b1-a398-b5a1-44be5bcf6eb3@redhat.com>
Date: Fri, 9 Oct 2020 15:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7d9328d2-69b6-5bb4-405d-5756e14688ec@wisemo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.10.20 14:55, Jakob Bohm wrote:
> On 2020-10-09 10:48, Max Reitz wrote:

[...]

> The error I got was specifically "Failed to lock byte 100" and VM not
> starting.  The ISO file was on a R/W NFS3 share, but was itself R/O for
> the user that root was mapped to by linux-nfs-server via /etc/exports
> options, specifically the file iso file was mode 0444 in a 0755
> directory, and the exports line was (simplified)
> 
> /share1
> xxxx:xxxx:xxxx:xxxx/64(ro,sync,mp,subtree_check,anonuid=1000,anongid=1000)
> 
> where xxxx:xxxx:xxxx:xxxx/64 is the numeric IPv6 prefix of the LAN
> 
> NFS kernel Server ran Debian Stretch kernel 4.19.0-0.bpo.8-amd64 #1 SMP
> Debian 4.19.98-1~bpo9+1 (2020-03-09) x86_64 GNU/Linux
> 
> NFS client mount options were:
> 
> rw,nosuid,nodev,noatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,
> soft,proto=tcp6,timeo=600,retrans=6,sec=sys,mountaddr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx,
> 
> mountvers=3,mountport=45327,mountproto=udp6,local_lock=none,addr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx
> 
> 
> NFS client ran Debian Buster kernel 4.19.0-0.bpo.6-amd64 #1 SMP Debian
> 4.19.67-2+deb10u2~bpo9+1 (2019-11-12) x86_64 with Debian qemu-system-
> x86 version 1:5.0-14~bpo10+1  Booting used SysV init and libvirt
> was not used.
> 
> Copying the ISO to a local drive (where qemu-as-root had full
> capabilities to bypass file security) worked around the failure.
> 
> I hope these details help reproduce the bug.

I’ll try again, thanks.

Can you perchance reproduce the bug with a more recent upstream kernel
(e.g. 5.8)?  I seem to recall there have been some locking bugs in the
NFS code, perhaps there was something that was fixed by now.

(Or at least 4.19.150, which seems to be the most recent 4.19.x
according to kernel.org)

> And I still have no idea why qemu tried to lock bytes in a read-only raw
> image file, there is no block metadata to synchronize access to (like in
> qcow2), when the option explicitly said ",format=raw" to avoid attempts
> to access the iso file as any of the advanced virtual disk formats.

I reasoned about that in my previous reply already, see below.  It’s
because just because an image file is read-only when opening it doesn’t
mean that it’s going to stay that way.

You’re correct that in the case of raw, this isn’t about metadata (as
there isn’t any), but about guest data, which needs to be protected from
concurrent access all the same, though.

(As for “why does qemu try to lock, when the option explicitly said
raw”; there is a dedicated option to turn off locking, and that is
file.locking=off.  I’m not suggesting that as a realistic work-around,
I’m just adding that FYI in case you didn’t know and need something ASAP.)

[...]

>>>>> The error message itself seams meaningless, as there is no particular
>>>>> reason to request file locks on a read-only raw disk image.
>>
>> Yes, there is.  We must prevent a concurrent instance from writing to
>> the image[1], and so we have to signal that somehow, which we do through
>> file locks.
>>
>> I suppose it can be argued that if the image file itself is read-only
>> (outside of qemu), there is no need for locks, because nothing could
>> ever modify the image anyway.  But wouldn’t it be possible to change the
>> modifications after qemu has opened the image, or to remount some RO
>> filesystem R/W?
>>
>> Perhaps we could automatically switch off file locks for a given image
>> file when taking the first one fails, and the image is read-only.  But
>> first I’d rather know what exactly is causing the error you see to
>> appear.
>>
>> [1] Technically, byte 100 is about being able to read valid data from
>> the image, which is a constraint that’s only very rarely broken.  But
>> still, it’s a constraint that must be signaled.  (You only see the
>> failure on this byte, because the later bytes (like the one not
>> preventing concurrent R/W access, 201) are not even attempted to be
>> locked after the first lock fails.)
>>
>> (As for other instances writing to the image, you can allow that by
>> setting the share-rw=on option on the guest device.  This tells qemu
>> that the guest will accept modifications from the outside.  But that
>> still won’t prevent qemu from having to take a shared lock on byte 100.)
>>
>> Max


