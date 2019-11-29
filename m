Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444AEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111FF217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MilspKpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111FF217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafQN-0007Qb-7f
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaf4B-0008FP-BC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaf48-0002Ri-BG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:08:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43510
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaf48-0002ND-6d
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575029282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=7yo/vmnvVWeeoGfOYDkf/p5Vz38rcr8vLA0gBBHr+8s=;
 b=MilspKpxqGnkaGZqD4Wm7U3FPSlgkmBbXBUwdYAoh1IPqIGIu124DfsONTyGG5cSyWOi2M
 l5SKzXVe0D3Kq/g09iPaizqz2X7p8eX4U1Db5ciBZijqvzh5Gsdt8N7t7ukSkcv9mFS5kg
 H9+96hUsGhMIij1f267GJkb4Tz0wsWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-R3TYYLe2PdS5QZ4Uy2Zktg-1; Fri, 29 Nov 2019 07:08:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362CB800D41;
 Fri, 29 Nov 2019 12:08:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA11D5D9E1;
 Fri, 29 Nov 2019 12:07:58 +0000 (UTC)
Subject: Re: [PULL 0/2] Fix for the s390-ccw bios
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191129100835.21734-1-thuth@redhat.com>
 <CAFEAcA8J4tJfa3-m_Lf4TUs6yvycp5v4umo8zp6-Cck6ACk=MA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f5203ce4-6684-42f5-8cf2-c5e2a54b5947@redhat.com>
Date: Fri, 29 Nov 2019 13:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8J4tJfa3-m_Lf4TUs6yvycp5v4umo8zp6-Cck6ACk=MA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: R3TYYLe2PdS5QZ4Uy2Zktg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 11.46, Peter Maydell wrote:
> On Fri, 29 Nov 2019 at 10:08, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit 1a61a081ac33ae6cb7dd2e38d119a572f416c=
7f7:
>>
>>   Update version for v4.2.0-rc3 release (2019-11-26 21:52:26 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-11-29
>>
>> for you to fetch changes up to bf876a688c9319b506d5ff1175ba7189cd933d91:
>>
>>   pc-bios/s390: Update firmware image with the "fix sclp_get_loadparm_as=
cii" patch (2019-11-29 10:12:33 +0100)
>>
>> ----------------------------------------------------------------
>> A fix for regression in the s390-ccw bios
>> ----------------------------------------------------------------
>>
>> ... it would be good to still get this into 4.2 if possible!
>=20
> Well, it's possible, but this is currently the only thing
> that would need an rc4, so the question is how important
> is the regression and how safe is the fix? If it's just
> a minor corner case then it's tempting to not have an rc4
> unless we need it for some other reason.
>=20
> Summary: it can go into 4.2 but you need to provide some
> rationale in the pullreq cover letter to make the case for it :-)

 Hi Peter,

without the fix, certain boot scenarios break:

- "-boot menu=3Don" does not work anymore.

- It's not possible anymore to specify the s390x-specific "loadparm"
  option (can be used e.g. with "-machine s390-ccw-virtio,loadparm=3Dxyz")
  This is e.g. important for booting alternate kernel that are installed
  on the guest's hard disk image.

The fix is just a one-liner, has been reviewed and tested by multiple
people already, so it should not cause any other regressions.

I think you could merge it also without doing another RC next week - the
people who care about s390x on the list already have checked the fix, so
we won't get too much additional testing coverage if you release yet
another RC before the final release.

 Thomas


