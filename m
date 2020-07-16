Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7836D20DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gZqIE3DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7836D20DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwCqQ-0005kY-Q8
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 18:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwCpo-0005Ct-J2; Thu, 16 Jul 2020 18:58:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwCpl-0008Tx-Jc; Thu, 16 Jul 2020 18:58:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B78mz3KM4z9sRf; Fri, 17 Jul 2020 08:58:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594940307;
 bh=LEt7S4JBoJob5ug/fBE47j/nEKgIvHPx1tLh0sV0WcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gZqIE3DBosKO0RtDrycItFw6HNymk7zwMDa2OSvVVfJa2Qfl1FXR+2vas3OYmDP9+
 v8joY4QseMZycbNN+O/3LihAIb5baDdOiR/Z8Vc0BjqgUGKqwhqz+Rp5Q7eDrcYum9
 +pvOEPbACUzYW+rQVL8lQdLsVXydmp/OX6xJBUUs=
Date: Thu, 16 Jul 2020 23:22:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client interface
Message-ID: <20200716132249.GB5607@umbus.fritz.box>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
> Ping? I kinda realize it is not going to replace SLOF any time soon but
> still...

Yeah, I know.   I just haven't had time to consider it.  Priority
starvation.

> On 07/07/2020 10:34, Alexey Kardashevskiy wrote:
> > Ping?
> >=20
> >=20
> > On 24/06/2020 10:28, Alexey Kardashevskiy wrote:
> >> Ping?
> >>
> >> On 02/06/2020 21:40, Alexey Kardashevskiy wrote:
> >>> Ping?
> >>>
> >>> On 13/05/2020 13:58, Alexey Kardashevskiy wrote:
> >>>> The PAPR platform which describes an OS environment that's presented=
 by
> >>>> a combination of a hypervisor and firmware. The features it specifies
> >>>> require collaboration between the firmware and the hypervisor.
> >>>>
> >>>> Since the beginning, the runtime component of the firmware (RTAS) has
> >>>> been implemented as a 20 byte shim which simply forwards it to
> >>>> a hypercall implemented in qemu. The boot time firmware component is
> >>>> SLOF - but a build that's specific to qemu, and has always needed to=
 be
> >>>> updated in sync with it. Even though we've managed to limit the amou=
nt
> >>>> of runtime communication we need between qemu and SLOF, there's some,
> >>>> and it has become increasingly awkward to handle as we've implemented
> >>>> new features.
> >>>>
> >>>> This implements a boot time OF client interface (CI) which is
> >>>> enabled by a new "x-vof" pseries machine option (stands for "Virtual=
 Open
> >>>> Firmware). When enabled, QEMU implements the custom H_OF_CLIENT hcall
> >>>> which implements Open Firmware Client Interface (OF CI). This allows
> >>>> using a smaller stateless firmware which does not have to manage
> >>>> the device tree.
> >>>>
> >>>> The new "vof.bin" firmware image is included with source code under
> >>>> pc-bios/. It also includes RTAS blob.
> >>>>
> >>>> This implements a handful of CI methods just to get -kernel/-initrd
> >>>> working. In particular, this implements the device tree fetching and
> >>>> simple memory allocator - "claim" (an OF CI memory allocator) and up=
dates
> >>>> "/memory@0/available" to report the client about available memory.
> >>>>
> >>>> This implements changing some device tree properties which we know h=
ow
> >>>> to deal with, the rest is ignored. To allow changes, this skips
> >>>> fdt_pack() when x-vof=3Don as not packing the blob leaves some room =
for
> >>>> appending.
> >>>>
> >>>> In absence of SLOF, this assigns phandles to device tree nodes to ma=
ke
> >>>> device tree traversing work.
> >>>>
> >>>> When x-vof=3Don, this adds "/chosen" every time QEMU (re)builds a tr=
ee.
> >>>>
> >>>> This adds basic instances support which are managed by a hash map
> >>>> ihandle -> [phandle].
> >>>>
> >>>> Before the guest started, the used memory is:
> >>>> 0..4000 - the initial firmware
> >>>> 10000..180000 - stack
> >>>>
> >>>> This OF CI does not implement "interpret".
> >>>>
> >>>> With this basic support, this can only boot into kernel directly.
> >>>> However this is just enough for the petitboot kernel and initradmdis=
k to
> >>>> boot from any possible source. Note this requires reasonably recent =
guest
> >>>> kernel with:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Ddf5be5be8735
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8QVKcACgkQbDjKyiDZ
s5K0ohAAlF7mKVb0FlVKf6SbB5Szp8tYGK4TAE3rmWzm0gGRxWwQpscKLmV79YjF
8aosF35w/Xzv6xwukukI/jmSNWgr5JMowqkbNIS/Tj8Sai0wnibjRkZvMAaA6Pxf
iMd8PfjrGd16HWC4GP/gkpgaVmJ5qBigsaGAkBMDCEO/fA/KTNXxcK9ex0fRCcyM
jqeIJqKE8X/9C1OeSxxCI5VI+jhl+scIo8bkQb3GQS9nI7s60JZ0EI4qcXris+sq
3XhoU9OvmGRoBfW0i8Lmpm1wQBGxGHDHYdkwtCO27/uC/YKdVEmVjWAWllIzipvz
elFbL8nPuE0tUdqGwinIJTzuNw5wwQkLMUTOvQ93w6EwDYRmdmcOzlGO427FWZAR
AOX+geP8Z5su6DmuknWlkaeC4XfELqBQkoo4IvfqwxDDMytKsJZP9q6tEMUTTg2p
LcrRk354f5bCURMsAwNej2wbg5b3Pkutxr6lBEeJ28bGMF40/Ubnwvd7T2GTsfWk
plGyD/HMWjgTwTjQ85B0HrUPqhJc7T0rXsqvNu7/qNORXPzKcj1/Az3QKmfy8Idp
2ffFuu2XNH76qxciMPH+o8XGMIrWrXy91P/Hf5lfdfTrAeq9N8SyzB7Wrnjwm5r3
pnoJPMy0nav+mzV7Ojpq7ZStgaVlTfRKf+woARbO+igMXoqLoh0=
=9tqQ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

