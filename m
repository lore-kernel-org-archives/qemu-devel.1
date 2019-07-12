Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D173C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546192083B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546192083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltwY-0003kp-Lo
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hltwO-0003GX-Of
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hltwN-0000qu-P2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hltwL-0000md-IV; Fri, 12 Jul 2019 07:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C5BA3082A49;
 Fri, 12 Jul 2019 11:42:12 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D7719C4F;
 Fri, 12 Jul 2019 11:42:10 +0000 (UTC)
Date: Fri, 12 Jul 2019 12:42:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190712114208.GH2730@work-vm>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190712111849.9006-6-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 12 Jul 2019 11:42:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 5/7] tests/migration-test: don't spam
 the logs when we fail
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> Quite often the information about which test failed is hidden by the
> wall of repeated failures for each page. Stop outputting the error
> after 10 bad pages and just summarise the total damage at the end.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Yep, occasionally you do find you do want the full set to see what's
going on, but this is true most of the time.

With 10 you should be able to see if it's a single page that's wrong or
the flip gone wrong.

> ---
>  tests/migration-test.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b6434628e1c..ce041f80c2a 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -308,7 +308,7 @@ static void check_guests_ram(QTestState *who)
>      uint8_t first_byte;
>      uint8_t last_byte;
>      bool hit_edge =3D false;
> -    bool bad =3D false;
> +    int bad =3D 0;
> =20
>      qtest_memread(who, start_address, &first_byte, 1);
>      last_byte =3D first_byte;
> @@ -327,15 +327,20 @@ static void check_guests_ram(QTestState *who)
>                  hit_edge =3D true;
>                  last_byte =3D b;
>              } else {
> -                fprintf(stderr, "Memory content inconsistency at %x"
> -                                " first_byte =3D %x last_byte =3D %x c=
urrent =3D %x"
> -                                " hit_edge =3D %x\n",
> -                                address, first_byte, last_byte, b, hit=
_edge);
> -                bad =3D true;
> +                bad++;
> +                if (bad <=3D 10) {
> +                    fprintf(stderr, "Memory content inconsistency at %=
x"
> +                            " first_byte =3D %x last_byte =3D %x curre=
nt =3D %x"
> +                            " hit_edge =3D %x\n",
> +                            address, first_byte, last_byte, b, hit_edg=
e);
> +                }
>              }
>          }
>      }
> -    g_assert_false(bad);
> +    if (bad >=3D 10) {
> +        fprintf(stderr, "and in another %d pages", bad);
> +    }

as Laurent says, the 'another' would need -10 but other than that:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +    g_assert(bad =3D=3D 0);
>  }
> =20
>  static void cleanup(const char *filename)
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

