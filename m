Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4DF2074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDzy5EsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4DF2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwNd-0000KJ-6U
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRwJ4-00040D-4J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRwJ2-0000Lk-DR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v3R7Tl094TTBLMND4R9nWU3yEDraIEYz6+TueuingzQ=;
 b=fDzy5EsB+wNMcxcXbOLXGYBl6eyQbZ8BPHF5JvgV38PSMXsraZ6DrAeyeJJ5Ef8/YuOANT
 ngm8uZmdKURrXKMRF5Preh5eL0uGmvWeEMdpL1XmB2WBSxxGTJaibNP2nRFR1pyEZtKJ3N
 knT85IZb5aRZuE9T4hCL5e2+m9pfTGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-sX5y9eliOgGs5EoGsczwqw-1; Mon, 12 Oct 2020 07:47:52 -0400
X-MC-Unique: sX5y9eliOgGs5EoGsczwqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB85F1018F64;
 Mon, 12 Oct 2020 11:47:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.193.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C974A61177;
 Mon, 12 Oct 2020 11:47:48 +0000 (UTC)
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
Message-ID: <7e7403a0-0491-d6c2-914b-048f48e7aecb@redhat.com>
Date: Mon, 12 Oct 2020 13:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7d9328d2-69b6-5bb4-405d-5756e14688ec@wisemo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>> On 08.10.20 18:49, Jakob Bohm wrote:
>>> (Top posting because previous reply did so):
>>>
>>> If the bug was closed as "can't reproduce", why was a very similar bug
>>> listed as fixed in RHSA-2019:2553-01 ?
>>
>> Hi,
>>
>> Which very similar bug do you mean?  I can only guess that perhaps you
>> mean 1603104 or 1551486.
>>
>> Bug 1603104 was about qemu not ignoring errors when releasing file locks
>> fails (we should ignore errors then, because they're not fatal, and we
>> often cannot return errors, so they ended up as aborts).  (To give more
>> context, this error generally appeared only when the storage the image
>> is on somehow disappeared while qemu is running.  E.g. when the
>> connection to an NFS server was lost.)
>>
>> Bug 1551486 entailed a bit of a rewrite of the whole locking code, which
>> may have resulted in the bug 1655408 no longer appearing for our QE
>> team.  But it was a different bug, as it wasn’t about any error, but
>> just about the fact that qemu used more FDs than necessary.
>>
>> (Although I see 1655408 was reported for RHEL 8, whereas 1603104 and
>> 1551486 (as part of RHSA-2019:2553) were reported for RHEL 7.  The
>> corresponding RHEL 8 bug for those two is 1694148.)
>>
>> Either way, both of those bugs are fixed in 5.0.
>>
>>
>> 1655408 in contrast reports an error at startup; locking itself failed.
>>   I couldn’t reproduce it, and I still can’t; neither with the image
>> mounted concurrently, nor with an RO NFS mount.
>>
>> (For example:
>>
>> exports:
>> [...]/test-nfs-ro
>> 127.0.0.1(ro,sync,no_subtree_check,fsid=0,insecure,crossmnt)
>>
>> $ for i in $(seq 100); do \
>>      echo -e '\033[1m---\033[0m'; \
>>      x86_64-softmmu/qemu-system-x86_64 \
>>        -drive \
>>          if=none,id=drv0,readonly=on,file=/mnt/tmp/arch.iso,format=raw \
>>        -device ide-cd,drive=drv0 \
>>        -enable-kvm -m 2048 -display none &; \
>>      pid=$!; \
>>      sleep 1; \
>>      kill $pid; \
>>    done
>>
>> (Where x86_64-softmmu/qemu-system-x86_64 is upstream 5.0.1.)
>>
>> All I see is something like:
>>
>> ---
>> qemu-system-x86_64: terminating on signal 15 from pid 7278 (/bin/zsh)
>> [2] 34103
>> [3]  - 34095 terminated  x86_64-softmmu/qemu-system-x86_64 -drive
>> -device ide-cd,drive=drv0  -m 2048
>>
>> So no file locking errors.)
>>
> 
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

I’ve tried using these settings, but still can’t reproduce the bug.

Nothing else uses the image when you try to attach it to qemu, right?
(Your last email noted something about a loop mount, but I’m not sure
whether that just referred to the RH Bugzilla entry.)

(local_lock=none means that all locks are relayed to the server, correct?)

Max


