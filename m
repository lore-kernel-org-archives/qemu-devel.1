Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E4C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0F0208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0F0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFJK-000076-6l
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hZFCp-0003bJ-HP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hZFCn-0000yZ-88
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hZFCM-0008VJ-Q1; Fri, 07 Jun 2019 09:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF2BA30C3181;
 Fri,  7 Jun 2019 13:46:03 +0000 (UTC)
Received: from localhost (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B49E382F6C;
 Fri,  7 Jun 2019 13:45:56 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:45:55 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190607134555.GB5220@stefanha-x1.localdomain>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
 <20190603123823.32661-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20190603123823.32661-5-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 13:46:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 4/9] block/io_uring: implements
 interfaces for io_uring
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
 saket.sinha89@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 06:08:18PM +0530, Aarushi Mehta wrote:
> +static void qemu_luring_process_completions(LuringState *s)
> +{
> +    struct io_uring_cqe *cqes;
> +    int ret;
> +
> +    /*
> +     * Request completion callbacks can run the nested event loop.
> +     * Schedule ourselves so the nested event loop will "see" remaining
> +     * completed requests and process them.  Without this, completion
> +     * callbacks that wait for other requests using a nested event loop
> +     * would hang forever.
> +     */
> +    qemu_bh_schedule(s->completion_bh);
> +
> +    while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
> +        if (!cqes) {
> +            break;
> +        }
> +        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
> +        read_barrier();

What is the purpose of this barrier?

> +static void qemu_luring_process_completions_and_submit(LuringState *s)
> +{
> +    aio_context_acquire(s->aio_context);
> +    qemu_luring_process_completions(s);
> +
> +    if (!s->io_q.plugged && !s->io_q.in_queue) {

Submit when there are queued requesting waiting for submission:

s/!s->io_q.in_queue/s->io_q.in_queue > 0/

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz6apMACgkQnKSrs4Gr
c8hQFAf+JmCkndK1lkTWo8RkodBdlVX97Dv2FbswRNPcxuIkSTABGJXCGRfACE1a
VWZl4vSMMwi2Kv71QHutYY2joobTMaPNyvFdIqDRXHdnPseTtZ2nPG7hAvbymws8
Zn5QqY605LaISjTmIIcPcdpIjBaZtZD21XXHh0pvMLdXVpzQZFFRx480dgVgayVF
t7ZLJJvYfzExOsDagddaSVQ/kICkuRIjhlIwijldN4r0w1WGMDPtHHnUtgFttQAP
SG32ckjX3j/Cd6pc87J0iLDkykHeld2yQS1KGmGC9a1+g1U6ILtYjerr4MBDMoha
HFk8JocnrLLrW06mhPnJVhKKejetZg==
=1QKV
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

