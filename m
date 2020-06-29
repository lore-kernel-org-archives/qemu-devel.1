Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CD523D4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIzdNg88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CD523D4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptRy-0005vS-5n
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptQe-0004wR-1p; Mon, 29 Jun 2020 09:02:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptQY-0002pX-LJ; Mon, 29 Jun 2020 09:02:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so15297893wmj.2;
 Mon, 29 Jun 2020 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+ERBaED2Tfl056/+rKaBgTkZ1q4DZ0SBGa95bPh6hCo=;
 b=mIzdNg882+Rwqg0VWOEUc7KL4NVHBpxtckFBuSeygnixC3vUTYm142hfVpk7a1YnJu
 Y/DdaTskO0C7LVc7FD0N9pI+cNGzKb8UiUIpeT1nZISyqfDVZpyxgq1OrQMr5mDPTcrh
 LQq+Qy4TeJrqjHFatpWShAqpOASiCrojvI0fz17ylJKf9T7xstmye15KB0OLI6bd7RDb
 ZhlzPgKpRv0kuKQXg4REeA8ngXqun9VaZuJd+aIczRRgcRZGUu/O7ssqYrn0dvE+Il4N
 Iu8sYRzcW/t0kAYSjKs028IilL27rWXIdSoLsUCyC5VbL2lJMRHoin9aiOID6s9og5Oc
 0mHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+ERBaED2Tfl056/+rKaBgTkZ1q4DZ0SBGa95bPh6hCo=;
 b=oJG/hVmrlz/irYe7llqonj4f6D0eJSOrX3teYRxZHvxzvW6qK7zzwXj2BcSeRF56d7
 kIu7ZIjyawxdRGgFNEau5/bMZjlQBunqCdYRmDx2idxIRrTouA9lEKmK1z3J4hodsMgx
 T/vju5C3XmO6OtHWtbcuYm5iNNtwsAHKud3kf2W1DAgFZApJKhskLd3EYHuK8JVBI13H
 BXJW5TfoDs+GxHBuMN2d0DgwJ90xE9mGPxxc2bCWdBvef/Z+OeBS3LVvKIDWFwFqBdOG
 axZqfwOSSf1uKNkmzvY8vibG0Oug1Bpep66ir5HEHVC4iSc8F7/O5Ar28xQsuHZS6Upn
 oYrg==
X-Gm-Message-State: AOAM532K8nj0RmIfvIUUWeU0lELJs8e4MYWLj/VDC/LmkGsUJ/vUGjvA
 CWt7HXpbdGwVs13qt9pzx2I=
X-Google-Smtp-Source: ABdhPJyObu/guHLHkf98UWyoJeel0fAFv9N509Tc7cXNXsqwO6cOfQNtIYgwS6a6KIpAzuXFM1XhuA==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr16541403wmf.103.1593435744760; 
 Mon, 29 Jun 2020 06:02:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d28sm52498608wrc.50.2020.06.29.06.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:02:23 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:02:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 01/17] block/nvme: Avoid further processing if trace
 event not enabled
Message-ID: <20200629130222.GJ31392@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-2-philmd@redhat.com>
 <20200626103651.GH281902@stefanha-x1.localdomain>
 <a3d7754c-38d8-ec9a-18d8-1a489d0c55ba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <a3d7754c-38d8-ec9a-18d8-1a489d0c55ba@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 04:02:43PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/26/20 12:36 PM, Stefan Hajnoczi wrote:
> > On Thu, Jun 25, 2020 at 08:48:22PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
> >> not enabled.
> >=20
> > Why?
> >=20
> > This saves 8 trace events, each with 8 arguments. I guess the intent is
> > to improve performance. Did you measure an improvement?
>=20
> No testing, I just tried to outsmart the compiler :/

Usually performance patches are accompanied with benchmark results.
Otherwise it's easy to modify code without making a difference or
accidentally introducing performance regressions. But this is a small
change and I'm not worried.

Please do explicitly state in the commit description that this is
intended as a performance optimization. I wasn't exactly sure about the
reason for this change.

Stefan

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl755l4ACgkQnKSrs4Gr
c8gLDQf/VTQhOLzQFow8lTFIDMhNpzKkFG8xvaqd+PhPT0wO3+M8RH2fUPqXyWs0
9lMtsUWipkJmXGB6ltsxWWsv4iIB19bG1j+K5MWH8SU0V4epxe7UbC+/EQaCd7cM
0bpKDpmJ/ZvHHIk+NeWBy/Vz9yYJYH7yCZzNbHgqy3hCgzrU/xyXgTfk0mKzZuGD
Le2Xb5MXsWxwQDbyA7gmguqDzHbI/VF1/LVTKcs6OM+TLkK/6DKfyc6Pi7xLZlCx
Z/B70NZxNfOniVpP/a3ri86J/Vy2gRLZgJN/kNawAPkYFk0oR0VTOkc1C0ft6IpD
oUnxz3zls6M9IK7KZmC9mms8qh/K8A==
=d58P
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--

