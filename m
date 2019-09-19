Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964FE218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FE218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAvuc-0008Ip-Vq
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 08:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAvs6-0006Ji-2d
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAvrJ-0000U8-Uo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAvrJ-0000T4-Mu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D178A86668;
 Thu, 19 Sep 2019 12:48:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7E3160BF1;
 Thu, 19 Sep 2019 12:48:25 +0000 (UTC)
Date: Thu, 19 Sep 2019 13:48:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919124824.GQ3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-17-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5KxTQ9fdN6Op3ksq"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-17-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 12:48:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 16/22] fuzz: add fuzzer skeleton
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5KxTQ9fdN6Op3ksq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2019 at 11:19:43PM +0000, Oleinik, Alexander wrote:
> +void set_fuzz_target_args(int argc, char **argv)
> +{
> +    if (fuzz_target) {
> +        fuzz_target->main_argc = argc;
> +        fuzz_target->main_argv = argv;
> +    }
> +}

Why calls this and why?

> +
> +void reboot(QTestState *s)
> +{
> +    qemu_system_reset(SHUTDOWN_CAUSE_GUEST_RESET);
> +}

Why does reboot() take an unused argument?

> +static void usage(char *path)
> +{
> +    printf("Usage: %s --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n", path);
> +    printf("where --FUZZ_TARGET is one of:\n");

Is the "--" prefix a libfuzzer requirement?  I would have expected
either FUZZ_TARGET by itself or --fuzz-target=FUZZ_TARGET (a properly
formatted long option) so that collisions with other command-line
options are not possible.

> +typedef struct FuzzTarget {
> +    GString *name;
> +    GString *description;
> +    void(*pre_main)(void);
> +    void(*pre_fuzz)(QTestState *);
> +    void(*fuzz)(QTestState *, const unsigned char *, size_t);
> +    int main_argc;
> +    char **main_argv;
> +} FuzzTarget;
> +
> +void set_fuzz_target_args(int argc, char **argv);
> +void reboot(QTestState *);
> +void fuzz_add_target(const char *name, const char *description, FuzzTarget
> +        *target);

This is a strange API.  I can't make sense of the struct,
fuzz_add_target(), and set_fuzz_target_args() without reading the
implementation:

1. set_fuzz_target_args() implies that there is global state but then
   FuzzTarget also has main_argc and main_argv fields.  I'm not sure
   what the relationship is.

2. fuzz_add_target() takes name and description as arguments but expects
   the caller to populate the struct arg's pre_main(), pre_fuzz(),
   fuzz() function pointers.  This is inconsistent and undocumented.

A cleaner API:

  /* Each fuzz target implements the following interface: */
  typedef struct {
      const char *name;        /* command-line option for this target */
      const char *description; /* human-readable help text */

      /* TODO documentation */
      void (*pre_main)(void);

      /* TODO documentation */
      void (*pre_fuzz)(QTestState *);

      /* TODO documentation */
      void (*fuzz)(QTestState *, const unsigned char *, size_t);
  } FuzzTarget;

  void fuzz_register_target(const FuzzTarget *target);

--5KxTQ9fdN6Op3ksq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DeRgACgkQnKSrs4Gr
c8gfFAf8DltdgV4sKWoVUWvaqZ2yg8CJ6Bx6e6l0kO8bu/iEGn4vIFVJuwXGoSp6
fbZ1a+TkfR/F32Cy5RIzyaK8z4oL6WtL6mmuJfMTkqDwBcYGr/2mWcBpQWGXro0m
iQlTARJJAOorpA3toQ3nB7g86jx3ix9igpD0YmW83/KfbY9X/WAIdNUHcdhTlcJA
ssIDwsnEgXd6CpLrUQ/zMKQfEhPYPIKLpp68kog4ENGrq3ZMWMg4t6TLgKQD4h0e
HXe1yfiAE7EdQ8upAGGnRKCgeHKEytaoOTCGSqB68aUuLnw61TEuXFusYYEpVHXK
5yh28NhHgMKB3Ip/MNqNpITSfkuudg==
=CR17
-----END PGP SIGNATURE-----

--5KxTQ9fdN6Op3ksq--

