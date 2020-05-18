Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA99C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D07D207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b="Eqw+5hKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D07D207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rev.ng
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jan7h-0007BH-Cw
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1jan6c-0006CV-4A
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:15:26 -0400
Received: from rev.ng ([5.9.113.41]:55737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1jan6Z-0003fH-QZ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TOV48mPEFkcUh5YE5b2AkLA7EIX7tfClTQmNPF8ep9o=; b=Eqw+5hKC63QiXsFxoQ7qUANOLJ
 2KbebrM/73Ow8E0hD4CigEG7v+8FNrHSkssQfpsc8KsLHEZfvd7EKQS79ntPK6zSrS8RJWCpAdoYS
 36pjHLKgIISWLItzeY+B9jwfqP+N1FAopzFZb2AVjJEeZxWUEcHU/KQbz3cKQICZ9qEk=;
Date: Mon, 18 May 2020 23:15:08 +0200
From: Alessandro Di Federico <ale.qemu@rev.ng>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Subject: Simplifying the Hexagon frontend
Message-ID: <20200518231508.141b524f@orange>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=5.9.113.41; envelope-from=ale@rev.ng; helo=rev.ng
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 17:15:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?B?TmljY29sw7I=?= Izzo <nizzo@rev.ng>,
 Brian Cain <bcain@codeaurora.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this e-mail is intended to bootstrap a public discussion on how to
improve the Hexagon frontend implementation. At rev.ng, Niccol=C3=B2 and I,
developed an Hexagon frontend, and we're (finally!) joining forces with
the QuIC guys to merge our efforts (did you see our talk [1]?).

The status is as follows:

* QuIC has its own fully working implementation that has been submitted
  for review.
* We're working to integrate in their implementation our mechanism to
  automatically generate code to generate tiny code. But this will take
  some more work.

In the following, some initial considerations on how the latest
patchset could be simplified.

Here you can find a graph I've put together of the build process:

    https://rev.ng/downloads/qemu-hexagon/temporary/graph.svg
    https://rev.ng/downloads/qemu-hexagon/temporary/graph.dot

Colors indicate language.
Oval nodes are generated.
Rectangles are hand-written.

Taylor, I think some simplifications can be made to the process in order
to ease the review process.

* As far as I understand, from he "Source of Truth" set of files
  (`alu.idef`, `encode_pp.def`...), through `gen_semantics`, you
  generate `semantics_generated.pyinc`, which is then included by
  `do_qemu.py` script, which does the real job.

  I would suggest to keep `gen_semantics` and all its inputs
  out-of-tree. It increases complexity in a non-negligible way, while
  bringing a reduced benefit in terms of automation.

  I'd suggest replace `gen_semantics`'s output
  (`semantics_generated.pyinc`) with a human readable JSON file that
  could be manipulated by hand and is then parsed by `do_qemu.py`. I
  think JSON is more appropriate than generating executable python code
  that is then imported.

* I suggest to switch to the decoding approach developed by Richard.
  That would simplify the build process and reduce the code that has to
  be reviewed.
  I'm not 100% of the effort required to do this, maybe Richard can
  weigh on this.

* The current implementation can generate a helper function for each
  Hexagon instruction and, for a subset of instructions, it has an
  "override" mechanism to directly generate tiny code instructions
  corresponding to the semantics of the original instruction (i.e.,
  without using helpers).

  This override mechanism is implemented with the `fWRAP` macros. They
  have benefits, but they are quite convoluted. We should strive to
  minimize the number of macros and alternative macro implementations
  to what's strictly necessary in order to generate as much code as we
  can from the "Source of Truth", but no more than that.

  As a simpler override mechanism, we could use weak functions. But I
  think that, for simplicity, we should try to get in tree a simpler
  version of the frontend that relies exclusively on helper functions.
  It won't have optimal performances, but it will be fully functional.

  Later on, once our work for automatically generating functions
  generating tiny code is mature enough, we can extend the existing
  implementation with an appropriate override system.

In the meantime, we're setting up a Dockerfile based on Debian 10
providing a minimal C toolchain that we can use to automate testing.

Feedback is more than welcome.

--=20
Alessandro Di Federico
rev.ng

[1] https://www.youtube.com/watch?v=3D3EpnTYBOXCI

