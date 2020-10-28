Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DEFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2059F24687
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIE0MaH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059F24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhmA-0004xX-1W
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXhlQ-0004PO-0V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXhlM-0002XM-8g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603877338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BnCitV6oEJak30otztINTTGbgWG7vK4zIxL0Ft2IvbI=;
 b=eIE0MaH6asYPhfY/stivSVgmgk3fOuHcPUz+Mg/VsrmMxiqYaGbaKa4zXW7+OVe+NWCwSQ
 WBgBfulGvjXx6VBz01viS0at0ae0H67WplwgFVF84njw6LlnVQfFDlIQf+mMrn4FtNZ4mc
 KQhjhioGF/UMmnk7HpgsHcVFdRLuBac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-77vtq1eKMH6GCbq0Jam0sA-1; Wed, 28 Oct 2020 05:28:55 -0400
X-MC-Unique: 77vtq1eKMH6GCbq0Jam0sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171021016CE6;
 Wed, 28 Oct 2020 09:28:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E03E127CB7;
 Wed, 28 Oct 2020 09:28:40 +0000 (UTC)
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
 <20201028091158.09df8b3c.cohuck@redhat.com>
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
Message-ID: <63e1d8d3-65a1-cffd-2fdd-724ba2cc9248@redhat.com>
Date: Wed, 28 Oct 2020 10:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201028091158.09df8b3c.cohuck@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28.10.20 09:11, Cornelia Huck wrote:
> On Tue, 27 Oct 2020 23:42:57 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Mon, 26 Oct 2020 at 19:39, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>>> ----------------------------------------------------------------
>>> VFIO update 2020-10-26
>>>
>>>  * Migration support (Kirti Wankhede)
>>>  * s390 DMA limiting (Matthew Rosato)
>>>  * zPCI hardware info (Matthew Rosato)
>>>  * Lock guard (Amey Narkhede)
>>>  * Print fixes (Zhengui li)  
>>
>> I get a conflict here in
>> include/standard-headers/linux/fuse.h:
>>
>> ++<<<<<<< HEAD
>>  +#define FUSE_ATTR_FLAGS               (1 << 27)
>> ++=======
>> + #define FUSE_SUBMOUNTS                (1 << 27)
>> ++>>>>>>> remotes/awilliam/tags/vfio-update-20201026.0  
>>
>> I assume these should not both be trying to use the same value,
>> so something has gone wrong somewhere. The conflicting commit
>> now in master is Max's 97d741cc96dd08 ("linux/fuse.h: Pull in from Linux").
>>
>> Can you sort out the correct resolution between you, please?
>> (My guess is that Max's commit is the erroneous one because
>> it doesn't look like it was created via a standard update
>> from the kernel headers.)
> 
> We should never change things in the synced headers other than via a
> headers update (excluding fixups of prior messes.) I'm pointing it out
> whenever I see something like that happening, but nobody is going to
> catch all of those.

Well, it was a kernel update.  Just based on a preliminary version of
the kernel part of the FUSE submount feature.

It was clear that the kernel part would have to be merged before the
qemu/virtiofsd series, and that did happen, but Miklos (the FUSE
maintainer) fixed some things on top while doing so, an that included
changing the flag in question.  As Adam wrote, I noted that I would thus
have to write a v2 of the virtiofsd series.

Unfortunately, that all was a bit buried in the thread, so I suppose for
Dave it looked like the kernel series was applied, so the virtiofsd
series could go in, too.  And I in turn didn't catch that. :/

> Is there any place where we can have some kind of automatic check on a
> pull request for that kind of stuff? We'd need to formalize an "update
> headers" commit message, or maybe have the update script write some
> kind of "last updated" file?
It would also need to actually check against the kernel tree, because,
well, I did use the script.  Just against a kernel tree that never came
to master.

Max


