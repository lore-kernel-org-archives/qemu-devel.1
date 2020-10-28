Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C4C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EB520735
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aijEb5k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EB520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhew-0000fZ-HG
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXhdz-0008EC-Kj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXhdx-0008AC-Pu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603876881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNgXZn6c6joHYQC/3Az2Swm/iuQTF2FPZjunESRK9BQ=;
 b=aijEb5k4erBlqCDlBPhKWPsjpi96CHMhRYU6uGQZkyCsf+kI/fpc+kpsLSqQ/Fm1QWePh5
 YyfrMQxrJfuwBiJnWQC7ge2UuK6vzWZeEKlPNYVgZc60IgVpzYW9d/DHysL5HL1CIq+sip
 DQbR6e4Zgn2YnKKvnmCErrsXCU3FpjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-2U7_a1f7Osan-COw-p76RA-1; Wed, 28 Oct 2020 05:21:17 -0400
X-MC-Unique: 2U7_a1f7Osan-COw-p76RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 726EA8070E2;
 Wed, 28 Oct 2020 09:21:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8423D6EF66;
 Wed, 28 Oct 2020 09:21:05 +0000 (UTC)
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: Alex Williamson <alex.williamson@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
 <20201027200021.00fac851@x1.home>
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
Message-ID: <b0423647-a03a-f601-bb16-2f161b3324ac@redhat.com>
Date: Wed, 28 Oct 2020 10:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201027200021.00fac851@x1.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28.10.20 03:00, Alex Williamson wrote:
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

Oh no.

>> I assume these should not both be trying to use the same value,
>> so something has gone wrong somewhere. The conflicting commit
>> now in master is Max's 97d741cc96dd08 ("linux/fuse.h: Pull in from Linux").
>>
>> Can you sort out the correct resolution between you, please?
>> (My guess is that Max's commit is the erroneous one because
>> it doesn't look like it was created via a standard update
>> from the kernel headers.)

It is the erroneous one, because it was based on an earlier version of
the kernel series.

> So as near as I can tell, QEMU commit 97d741cc96dd ("linux/fuse.h: Pull
> in from Linux") is fantasy land.  The only thing I can find of this
> FUSE_ATTR_FLAGS outside Max's QEMU series is this[1] posting where the
> fuse maintainer announces that he's replaced FUSE_ATTR_FLAGS with
> FUSE_SUBMOUNTS, but the usage is "slightly different".  Reading that
> thread, it seems that virtiofsd probably needed an update but I can't
> see that it ever happened.

No, it didn't happen yet.  The series should have got a v2.

As an alternative to reverting, I could try to fix it up on top, but I
don't think that's really preferable.  So I would vote for reverting.

> I'm not comfortable trying to update Max's series to try to determine
> if FUSE_SUBMOUNTS can be interchanged with FUSE_ATTR_FLAGS, where the
> latter appears to be used to express the new field in struct fuse_attr
> exists, but the former appears to be a feature.  My guess would be that
> maybe FUSE_KERNEL_MINOR_VERSION needs to be tested instead for this new
> field??

It can't be interchanged 1:1.  The series should be updated, but not
with such a hack as using some other indicator to see whether the flag
is there, but with properly using FUSE_SUBMOUNTS.

(I suppose technically it's OK for the virtiofsd side to interpret
FUSE_SUBMOUNTS as meaning the field to be present, because
FUSE_SUBMOUNTS does imply that.  But I wouldn't want to test that
hypothesis, and instead just write a clean v2.)

> Anyway, I hate to pull the big hammer, but I think Max's series is
> bogus.  The only thing I can propose is to revert it in its entirety,
> after which this series applies cleanly.  I'll post a patch to do that
> as I think the code currently in master is on pretty shaky ground with
> respect to interpreting flag bits differently from those the kernel
> defines.

Sounds, well, not good, but definitely reasonable.

Thanks!

Max


