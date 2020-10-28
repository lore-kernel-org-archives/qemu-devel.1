Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388CFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE752242F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1yPqfLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE752242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcEB-0004Vr-R9
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kXcBl-000277-4q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kXcBi-0007EB-60
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603855907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opa5j4gDB5T9IjkAV4KBbGwr0TwFflN1lpDnSgW2WmI=;
 b=Q1yPqfLPO2dhggCopPmrssw+tc4dtE4fV3L1n7uo2E7IZnZIcFQM6DL4BC6qnzdjCFr2Ba
 3hFxramE0jsB9f0chvXgkMhjPWJ4ZcrU+KqnS9aLi0uSJJmhmE0p96t3sfF5s+A3OlYGn+
 4vfXmJsEcw75Ax49P1UtQsYwMNZ04Io=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-AZbg7bHJMW62UF3K2idWAg-1; Tue, 27 Oct 2020 23:31:44 -0400
X-MC-Unique: AZbg7bHJMW62UF3K2idWAg-1
Received: by mail-pf1-f197.google.com with SMTP id 64so2149523pfg.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=opa5j4gDB5T9IjkAV4KBbGwr0TwFflN1lpDnSgW2WmI=;
 b=enxnixYjVZ/QK3E52XEj6OEUtb0Lox656Tw75dpZx86F7ZG05pLRL2fOH2mdttr2jC
 PhpQvkHPke4ZcVUd2Qd1Njmtxrj3B0dG/JyxbfomMhRJc4oNVWNIoy8jjNx7/+saobh8
 it5e732xelFiBdi9DScUycnbQ4TQCCHxYUNTJLT1nNaJFN4DC3ge2o97RIrlbYiNlcfV
 HwQ+1vB3zVawHdPmQQ9ulgfBmq/rUEogGCtgkdi0ZoVyd0Pf8IJalq6Hiovr8bGu19zr
 Tu800Pn7jXX97cdxfOFbOCOwlQty09t2wtA71Kazya043TvYr1cRjqEhhrzAdPyX13Fp
 KFzg==
X-Gm-Message-State: AOAM531ulTJJBYMdeh2X5xoe1RIaQyhDxDF3bk0GIVPC0/JJRsyV+7eq
 9DOFwz82QkkMDeXEJI21JJNPYH+tMc9Ulf3oo+GzO1+hLqIKYLtF3zBqpNcnHEfobgNO68atGoo
 u1vaheYC1BIi/sfk=
X-Received: by 2002:a17:902:9f8e:b029:d6:52e9:1da5 with SMTP id
 g14-20020a1709029f8eb02900d652e91da5mr5681314plq.20.1603855903576; 
 Tue, 27 Oct 2020 20:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQLLKV3+y02EKv8hcwt1OWxjo9dkYNBdtE4ImYprlYncDO98b4elh+PT1zeCuTlPliBDiMyg==
X-Received: by 2002:a17:902:9f8e:b029:d6:52e9:1da5 with SMTP id
 g14-20020a1709029f8eb02900d652e91da5mr5681299plq.20.1603855903291; 
 Tue, 27 Oct 2020 20:31:43 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e000:a00:52ee:f101:6b37:1519])
 by smtp.gmail.com with ESMTPSA id q125sm4022280pfq.120.2020.10.27.20.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:31:42 -0700 (PDT)
Date: Wed, 28 Oct 2020 14:31:35 +1100
From: David Gibson <dgibson@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201028143135.51c0a918@yekko.fritz.box>
In-Reply-To: <20201027135426.765dd19b@redhat.com>
References: <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
 <20201026174537.128a4173@yekko.fritz.box>
 <20201027072430-mutt-send-email-mst@kernel.org>
 <20201027135426.765dd19b@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/ZC0_sk_b4RIqtEoFnzH8Qk2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 22:00:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ZC0_sk_b4RIqtEoFnzH8Qk2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020 13:54:26 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 27 Oct 2020 07:26:44 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
> [...]
>  [...] =20
> > >=20
> > > It certainly shouldn't wait an unbounded time.  But a wait with timeo=
ut
> > > seems worth investigating to me.   =20
> racy, timeout is bound to break once it's in overcommited env.

Hm.  That's no less true at the management layer than it is at the qemu
layer.

> > If it's helpful, I'd add a query to check state
> > so management can figure out why doesn't guest see device yet. =20
> that means mgmt would have to poll it and forward it to user
> somehow.

If that even makes sense.  In the case of Kata, it's supposed to be
autonomously creating the VM, so there's nothing meaningful it can
forward to the user other than "failed to create the container because
of some hotplug problem that means nothing to you".

>  [...] =20
> I have more questions wrt the suggestion/workflow:
> * at what place would you suggest buffering it?
> * what would be the request in this case, i.e. create PCI device anyways
> and try to signal hotplug event later?
> * what would baremethal do in such case?
> * what to do in case guest is never ready, what user should do in such ca=
se?
> * can be such device be removed?
>=20
> not sure that all of this is worth of the effort and added complexity.
>=20
> alternatively:
> maybe ports can send QMP events about it's state changes, which end user =
would
> be able to see + error like in this patch.
>=20
> On top of it, mgmt could build a better UIx, like retry/notify logic if
> that's what user really wishes for and configures (it would be up to user=
 to
> define behaviour).

That kind of makes sense if the user is explicitly requesting hotplugs,
but that's not necessarily the case.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/ZC0_sk_b4RIqtEoFnzH8Qk2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Y5hcACgkQbDjKyiDZ
s5IEtw/+IbhbnswOMAI/w8MeD32NvNsnKybEh+AFewqIfXbsH400k/iHC/rnrTTf
DBxnSL9688Gff6dVkOEQWFb05hE06njz+BT+KGjHKGlNwEwjiETHyM8d3xeiTAju
YEHzwlviIYqYoLmdB56+Vdu0WYnxRI7YLbXXoB8EMKK1XnpruHNxY5D+pfZB0nQI
zNW56uAovZTbUydH/E5lfqNAxXlfYILN9ea4QSmon67M/SyzWwGQ9UbSwPe9BkkD
4FxNumhh7vq8Iw7azPdO4faJlCqylSD+Eb00R+R5SRJ0kFRoQc18tCD0j0aW02ny
61au4kNWy2BbHzQ2AjujaN8oQ5YSCU5xpGMimd6Puy9ribdmyWTPwalPf8VCms6k
MrQbuO6MWv5JKLof3SXdb6OUl90xTRE0OuoXvKgaq8/u1qIBPi9GIh0rOumtt4XR
8nUNeVkXAxwmKnZMMHCGi9AxaTcSD/0ploohU+TbWiPGbtYemNM1FGciKzRFZdmn
4twpjgjZuDG/WI0UR89nLPCyQtStUDj9p0kLckh/hnbbVD6bK8ZwrewJkvvvXTrm
yOlxpsCW2po4izM5VallyPucTQbTowIZE1hticFRcpsKUx1iH8+g2BM0KQ19eVzt
6s+wrYBIacKu+izuqTpDuJHkQirQ5oKQk3gct44atBObia9rmm8=
=l+y2
-----END PGP SIGNATURE-----

--Sig_/ZC0_sk_b4RIqtEoFnzH8Qk2--


