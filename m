Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F14C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04689206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHcv3YJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04689206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRbT-0005y6-1G
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1isRao-0005Z8-AQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1isRak-0006t2-1J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:23:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1isRaj-0006nV-9G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579267391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9r27ABPOvVhS7P4SC5Jm3ZE+dkizbgXFevq5ijYW1Vc=;
 b=GHcv3YJBTeXoovoLaRURQ/rVxDprWu8AfKBX8vNsldL9Po28Cq7iy+14vdDuJoAVdEjPok
 t/+v61zjxH5WJXjGRrghRn72G3a5KCFV18gxU30e4itu4KPg5Y3Ts1axbvL/fSBbh7bm60
 Xu5Sq61vh7ZhGTfVZ5LGQ6kIScymWXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-OBakx1B3M4eOK1gpBgLd5Q-1; Fri, 17 Jan 2020 08:23:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5DF08017CC
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:23:01 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6709460C87;
 Fri, 17 Jan 2020 13:23:01 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id BE8733E0489; Fri, 17 Jan 2020 14:22:58 +0100 (CET)
Date: Fri, 17 Jan 2020 14:22:58 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: qemu-cpu-models: Document '-noTSX' variants and
 'mds-no'
Message-ID: <20200117132258.GB24159@paraplu>
References: <20200116173639.28524-1-kchamart@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116173639.28524-1-kchamart@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OBakx1B3M4eOK1gpBgLd5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 06:36:38PM +0100, Kashyap Chamarthy wrote:

[...]

>   (2) There are _three_ variants[+] of CascadeLake CPUs, with different
>       stepping levels: 5, 6, and 7.  To quite wikichip.org[*]:

s/quite/quote/

>=20
>         "note that while steppings 6 & 7 are fully mitigated, earlier
>         stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"
>=20
>       The above is also indicated in the Intel's manual itself[+], as
>       indicated by "No" under the three columns of MFBDS, MSBDS, and
>       MLPDS.
>=20
>       [+] https://software.intel.com/security-software-guidance/insights/=
processors-affected-microarchitectural-data-sampling
>       [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_l=
ake#Key_changes_from_Skylake
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> TODO:
>  - I think I also need to add a note about 'tsx-ctrl' bit.  Here too,
>    same question as above -- does it show up in /proc/cpuinfo/?

While at it ... if I mention 'mds-no', then it would be inconsistent,
and inaccurate, if I don't also mention 'taa-no' IA32_ARCH_CAPABILITIES
MSR bit.

In short, I should mention the following MSR bits, and their use, in
context:

  - mds-no
  - taa-no
  - tsx-ctrl

... while bearing in mind that none (?) of these MSR bits will show up
under /proc/cpuinfo in the guest, rather they're used to populate the
relevant vulnerability file in sysfs
(/sys/devices/system/cpu/vulnerabilities/).


[...]

--=20
/kashyap


