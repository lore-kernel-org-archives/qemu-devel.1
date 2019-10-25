Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F605CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADCD21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="H+xgh0u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADCD21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3NN-00072Q-MN
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iO33A-0000yD-1Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iO338-0005gh-Si
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:06:55 -0400
Received: from mout.web.de ([212.227.17.11]:50615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iO338-0005cC-JH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572023193;
 bh=swJni6b4V8pRAk84eLDd3KajcXs6Pvhgess3/vHrBUY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=H+xgh0u2H/wAFORxkZDCUcm61I2TThjkp0xTq0hQ3ZHil+GPYM5Z7dvfavJygDH7s
 9RhJSEmQzibMOLCiZwduZ+sIR/C7/cYgynbazIT6e3dU+SgMh74UutPFOQvTLlUclZ
 LcVvfefjpvNaspR1wmSqN4fbe4WntdPHMkloBS8o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.116]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GVO-1iHxRe3huA-00CeS7; Fri, 25
 Oct 2019 19:06:33 +0200
Date: Fri, 25 Oct 2019 19:06:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 0/4] colo: Add support for continuous replication
Message-ID: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ir2Tllt7UTjwaNgP9n3MqVVRxUHpbyiSyEfbljDG87JfEd6Nofh
 Tjlvx2DLmMPuaPx+7iOLb5a6ofTGPr75PBxfZDu/4aAJ0o/jOnlTy+dOVLthi0tHFh6ulJu
 680wDDTdfG9lz9jGJGTv+j+5peI/5VzgE81YnRBZyPWPo/PoB9j0FCXHSijUbbSB2gdMVsy
 O4G1l+nQx2NzRZ3+SRNSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3T8tkHj2uDQ=:IRlnrMRIG0gd2nG3yiyPPO
 mOYUWavR2+EZNr9ltO6Q1bChbX48WqjPnvDec/3LJFEaOH+9H7GnmAnL96MiDEzb+oWLiOnfr
 7pbokNo+hbfGsPwf23MudZtUm2sZfRI+O9ciIXxHQxZrB7PIhcNC3LGFO6eEZIHCLScEVI84k
 pywjJJZiGLRtWuFXgPWxUpN7CcV7UnKc3jXnhcKExyqN8Kypo+PwlKly/Sinf1mdqIEKHz2w4
 qIBfNMSvzzw0OBLajCc8DcVUYeNImHeH6myEPA5Lo4dxT1foYSUYQhU1je+qnKMGQqqGUXJZl
 oFvyoeLwrJxyHX4pcYRlPt0A/hiESqRgC4jErW+5EEgZGUmEBaOSMUzMN3HU2B5UW9Wj+/2X0
 IJcYVPfcr6rfB5jNSyJtiDMaMm79yUqGZi85weFiOLIXTh8vUOJ+qU1r7PaQ/1GwteNVPGDpW
 +ExbF8PV13qMK2ple1a1y32hKBM122JVe0dICDF3r/lFcFYVMU/agLHiQ8Y+wxHtZokWTneS3
 a9DcCy4CBKgnJ2kInXD3owjE8mnQy8KCZH6MBAkjw85JF15NeVUOKkmVu74P/JJ9BIFdzGxfb
 hForrd7intBgtb+LaOAr/5BA4fm2e7QZWsg3RETcIZIbtupOtCYaWbrAbAjver/7z1kBBaNHw
 OMFWQpSVQWZ4nQIfWIL5xZrnAPaN6hv1d9PY2PqsurkPVfctOVRxw5nX60czbZ0EDdWsl9gPS
 e8GtO64CZmmZNIdXRhJfbFwfpwWe7tm+wmK5BvN4j1kTisQJQDHeF2joZnzzoGhg3jMyXZ7FH
 jg+0rRo2044SPDfyGUqYtw7V6vhqyklEgERIcZGq56zQhCZziYEye12h7di4MCK76HkVGVHv7
 oG7yN99tl1Mkmgyo1P+5xvO8uWwffO0y+I7y9lYQGUhBLXiqJ7hUrdqtgz4rSf8OK1F4tF2Vr
 r1NcFg1+Sul67BdpX6HTdIKjummFagXrSXjrR7XDr+aclk8heY5nc1IJ7cL/rqUiHO0MC17nX
 Xl8gJJepP5ApaE3BOqE9XKq9yWU0r1l+nkpvH8/HNiinv7L8XlMUobFnGEk/fWZhLctST3SU9
 IsGlkZX1r1UN5LDfbWiM+lthVvwrzZpAn8O3A/lzKqjNnY9k+tuvA+FWAkoXnLgIM+2RWXEUn
 f9RH53wznl7YVWf2lkOProZWfD1zfervhY+8t4XrUIE3TceMbZh29lgh9sdvwAoRNyYOKBUBY
 OC2bZGFekHIR4a+kWpmM1qT8423llaeDYUm3KIVjCstD7URsW3sn0huCjN9U=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continuous replication to colo. This means
that after the Primary fails and the Secondary did a failover, the Seconda=
ry
can then become Primary and resume replication to a new Secondary.

Regards,
Lukas Straub

v7:
 - clarify meaning of ip's in documentation and note that active and hidde=
n
   images just need to be created once
 - reverted removal of bdrv_is_root_node(top_bs) in replication and adjust=
ed
   the top-id=3D parameter in documentation acordingly

v6:
 - documented the position=3D and insert=3D options
 - renamed replication test
 - clarified documentation by using different ip's for primary and seconda=
ry
 - added Reviewed-by tags

v5:
 - change syntax for the position=3D parameter
 - fix spelling mistake

v4:
 - fix checkpatch.pl warnings

v3:
 - add test for replication changes
 - check if the filter to be inserted before/behind belongs to the same in=
terface
 - fix the error message for the position=3D parameter
 - rename term "after" -> "behind" and variable "insert_before" -> "insert=
_before_flag"
 - document the quorum node on the secondary side
 - simplify quorum parameters in documentation
 - remove trailing spaces in documentation
 - clarify the testing procedure in documentation

v2:
 - fix email formating
 - fix checkpatch.pl warnings
 - fix patchew error
 - clearer commit messages


Lukas Straub (4):
  block/replication.c: Ignore requests after failover
  tests/test-replication.c: Add test for for secondary node continuing
    replication
  net/filter.c: Add Options to insert filters anywhere in the filter
    list
  colo: Update Documentation for continuous replication

 block/replication.c        |  35 +++++-
 docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  28 +++--
 include/net/filter.h       |   2 +
 net/filter.c               |  92 ++++++++++++++-
 qemu-options.hx            |  31 ++++-
 tests/test-replication.c   |  52 +++++++++
 7 files changed, 389 insertions(+), 75 deletions(-)

=2D-
2.20.1

