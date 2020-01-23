Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA08217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsz1wQ+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA08217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuZ00-0006OT-En
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 04:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iuYzK-0005xD-Fn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iuYzI-00027J-Ub
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:41:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iuYzI-00026y-S0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579772480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mZKw7xrZgmVCKC3WEy8tCfmrjKlux6wjBXVwmVS+BY=;
 b=Fsz1wQ+SAudN7fq3bA4tgBNisORupS86f21PfqTObuwsDN5PND18lhUglP0fGtU0PBdMz4
 PXNIUunK6SF8BvHKvbAwKh6Jchusejf4PDhEiWIS36ZV25fk+ZJziHgBBqGX6XsrIQxr44
 YAYC2+mE8Ncv1pKlbd7nOUvXcTEp7Co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-LBSp2JOTNH-dT5GUqY07ew-1; Thu, 23 Jan 2020 04:41:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0300880059A;
 Thu, 23 Jan 2020 09:41:15 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-226.ams2.redhat.com
 [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC4EF2898E;
 Thu, 23 Jan 2020 09:41:13 +0000 (UTC)
Subject: Re: Maintainers, please add Message-Id: when merging patches
To: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org> <9ac75d71-731d-a9d8-4ba6-f394077c4d96@redhat.com>
 <87k15jz5e8.fsf@linaro.org> <20200122200738.7be66e3e.cohuck@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e2fa44a4-9552-7983-0181-761b91deb8c4@redhat.com>
Date: Thu, 23 Jan 2020 10:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200122200738.7be66e3e.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LBSp2JOTNH-dT5GUqY07ew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/22/20 20:07, Cornelia Huck wrote:
> On Wed, 22 Jan 2020 18:56:47 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> On 01/22/20 13:30, Alex Benn=C3=A9e wrote: =20
>>>>
>>>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>>>  =20
>>>>> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag=
.  Hooray!
>>>>>
>>>>> Message-Id: references the patch email that a commit was merged from.
>>>>> This information is helpful to anyone wishing to refer back to email
>>>>> discussions and patch series. =20
>>>>
>>>> So I guess the ones that don't are maintainer originated patches unles=
s
>>>> you actively rebuild your trees from a posted series? =20
>>>
>>> I *think* this should not be a huge problem process wise:
>>>
>>> Assuming that a maintainer does not include their own patches in a PULL
>>> request for Peter until the same patches receive R-b/A-b/T-b feedback
>>> from other list subscribers, the maintainer will want to rebase the
>>> patches at least once anyway, in order to pick up those lines. =20
>>
>> Oh I always do a re-base as I apply the r-b/t-b tags. But that is
>> working off my tree and a bunch of references to the emails with the
>> appropriate tags in them.
>>
>> So which Message-Id should I use. The first time the patch was posted to
>> the list or the last time it was?
>=20
> From the last one? I mean, I'll pick the last incarnation if I apply
> someone else's patches, as well?

I think so as well -- pick the IDs from those messages of yours that
another maintainer would apply with git-am.

(BTW I've had another thought -- git-send-email prints the message IDs
it generates while sending the emails, so one could pick those up with a
git-rebase/reword right after posting, too.)

Thanks,
Laszlo

>=20
> [I just add the id right before I send my 'queued' email.]
>=20


