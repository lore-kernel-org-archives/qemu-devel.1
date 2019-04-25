Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4807C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6972208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8slBXcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6972208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZo9-0007bE-Tx
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:32:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZmM-0006MA-4f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZmL-0003Za-6r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hJZmL-0003YX-0F; Thu, 25 Apr 2019 04:30:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id y197so9263640wmd.0;
	Thu, 25 Apr 2019 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=GlWek/9hdj4qvKeModRnRPSc1k4MOnz48J+yziPEQ9s=;
	b=a8slBXcE/ss0Rd/bgbgbMQlL+PK4QCOF2vf5Qfj7Y66Wne0k5LI1invB33PJZ+z0aU
	DvZSDCkBgwevB9VkPb93jWAKhMyNBk0BM83qYNjoqJDiWRHTMjGBM0IhIYwAjkSm13yS
	EXCFE+DNqf2OQ/NfxjXejftL4MKZQIz1xmB9UHlV+aiZCeudZQFBJXlXjpieoKjbrG09
	kFZiaIlogAo6jUjICKJDYWb6P7HFQcgrUCI2dPfIWexsYw94pPHibscLwNX5rsrM58w7
	gO2pIXZHORr2iGZufgVmixVtLmPaxlsy9AUnWg8S5TeRyNGgWuhui5Fg0DPYECDJOF6X
	0WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=GlWek/9hdj4qvKeModRnRPSc1k4MOnz48J+yziPEQ9s=;
	b=ViludxojVDEkVTAhhKXFXXV3nMA1MdqiytLAZ+ArXEfhZBGpiCCbR95YTzoq0xfOzc
	e0RVrAiG2n0+GkCvXGQH80nzy4IaW4g6c1CWeL/knrN5rsL3lcHrJ+IETPxJN20bfSkx
	R1War6uiQhJp5/dCdzTy7nlsiv2zWfbx5Ou7uP1Z8Zlc8aPnIsa9w7HTrmzCZlCMxq7u
	b59gXvXI2nWnrMDQipZpsmzg0Ss9QDFLbwKLLiHibLRqbBoJ6N51whSVSye9sUWP1KG2
	fDYJvqPqcDFLuvOVk9aCXKZKvnxXvY1mmhtxeY2UQvM/D9CHbSjaHuUiM87m2ejdk0Iy
	lk7g==
X-Gm-Message-State: APjAAAVyDcWnljN3uZof6uGKWMGWX5ilVAW4BeQGMD/TomjDWiOrVEK/
	JMnuWSfncJwRNRkpS7QxBvY=
X-Google-Smtp-Source: APXvYqyYUguVRNDdo5o04X5b9+6PFXnozWIxqaNetO4utrTWuCePHhDA8lt/wGp7VKT8SWFJZhHLsg==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr2357778wma.57.1556181047528; 
	Thu, 25 Apr 2019 01:30:47 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id e3sm5094450wro.35.2019.04.25.01.30.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 01:30:46 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:30:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190425083045.GC30231@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
	<20190423094217.GC6022@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20190423094217.GC6022@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BQemu-block=5D__question=EF=BC=9A_Does_?=
 =?utf-8?q?qemu-pr-helper_have_its_own_log_files=EF=BC=9F?=
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Zhangbo \(Oscar\)" <oscar.zhangbo@huawei.com>,
	"Fangyi \(C\)" <eric.fangyi@huawei.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, Jie Wang <wangjie88@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425083045.CTbulsTcBGQdH1GOz_FDSvk9u-rcQ_zljwtijRrK4yE@z>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 10:42:17AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> > =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F
>=20
> When QEMU launches it, i think it just inherits stdout/err from
> QEMU itself, so errors appear mixed into QEMU's stdout output.

I thought QEMU does not launch qemu-pr-helper.  Have I missed something?

QEMU ships systemd .service and .socket files for managing
qemu-pr-helper externally.

> When libvirt launches it, there stdout is connected to /dev/null
> and stderr is connected to a pipe which libvirt closes almost
> immediately. This means any errors are lost as any attempt to
> write to stderr will get EPIPE :-(

For anyone looking at the code:
src/qemu/qemu_process.c:qemuProcessStartManagedPRDaemon()

Stefan

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXA1AAoJEJykq7OBq3PI/QoH/3PwwjgmRYq6fAoTt4Xu6FBU
siKILMWL7wMWjzvxUIs+JY2ZeOXbvci6mT0zOvGqhNAiQANKVNhUunze576ZtFlD
Ug2ePB4AuU3ccwAElR0zpJoneoJMU1T6ksIxLh4V/NwBDtQL1dNYFN7VSulLKxbo
YMI0BZQ8ky7eZXCx7nSmHgF9BtdjxLqsvPMDtmSkOb6SXpnneTq+6FQRYTImSYEt
o5Gp/bcc5NTgc67/tGfSPCEl1qqDdEQ6YN/S/mSk8tZkcbqoDpX0J/tpp4oDThI3
g1o5yFTOHxeExtsk+Vff7bDXg3QRC+0gyn+IFA8XX8opWlOglN89SlR8qZceUL8=
=0xgx
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

