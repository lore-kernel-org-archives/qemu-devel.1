Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F63C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8032067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JSiLbTTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8032067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheOP-0006R8-9k
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKf-00049p-SE
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:17 -0400
Received: from mout.web.de ([217.72.192.78]:37843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKe-0005ZK-Ta
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471063;
 bh=b5CLc7E0ETNwdxt6ukjNQqIWYxcIdK2wDTmbp7UeqFo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=JSiLbTTIDm7WLNqXiO5kfVh1bP+nYtZmYMIqfQ1HTvo5wxPMwYgrNPb4XusnYlTTY
 D9U0+zWx8f1h2/mXnTyAodAQEQL9aeJ0nfYilP+0FrxZbqCSzKqNcvda3cU/MGYv4P
 uy5WOXanOU8PYiOSeIcYSxj/ur7eTi55CoZgUJcc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Va-1jH4wp0pWK-00iDZ3; Sat, 06
 Jun 2020 21:17:43 +0200
Date: Sat, 6 Jun 2020 21:17:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/7] colo: Introduce resource agent and test suite/CI
Message-ID: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+fhpLNQ1ii_a.pX8CXQEElE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IxtM9lrTmdoHj4BOAxjBDh+MMf1wDSkNthzYH7jQAgxGQWMmjVw
 LvOk93QfcNcWMpskJ1avm6NZqXTTIwSgVt4qJ6uGVQYWGxPF9XycyKY+LPOj6ZaLpD3N086
 jv7+YAR/9HCbC+MnBefIVy/kUvjFK5b6a34Tfr3qP4s3ciY3W3XG2dOVF/D8+VGm6cxq3UH
 NVZjnCP8E0DxNnOXCdSQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EOBM1qmJ4Pc=:IznEOlOpJN4szU5QIcXWUL
 56jfIjjjIPPAiKBkcRAxU3shKDYBc1odtP20UKcZyaJTnZPsfduLNUbLzb7cPM3TBf+G+D+9m
 koI0X5X9Tfx8Zb8aJcGahXqy7j9UwYAgq+9f0mqlEAOrRnuLgFQhJTQwTobEqMF9w6l/SGHTl
 iFg0Frb55L7M//cw7PbUEILNH3WaNltOJxJTqsHBDKddncN4icRsANHjyf5jkxrD7TJPSUW3k
 TAm+BIW19dKY7vVylhSFw4YCAPbscWGo2n2dSeIwpfjAA0WW8fYxJrOEbSjR0gBNlPY04ZhLN
 SDnxuEvf2h3OuYeCptkHWLj7JYWNlCPpZ6JcyI9w7R5fa1+K7JdAUQIybDKskPur5NzE4kjT+
 xrTaxIYZWBavWbXr5vYy/iMsHOIBmDJmp/VJxTK/PR8K3VA/tua+kHhhPL5MHsJqfmn0NymjX
 1Xk5zBoGyBniDB3YWa4gMrSGfE1rTYQVt24I5BxfzUt5j+8A42o3uITgKfTUcuLBm5bznVqYJ
 Q64NCOdt0uuY8fS8P/gHPWLh7b/Ci2MCQmz+B8cE0DGc7ZUszLzeJt2rkXfxaIVRCQ/3XULCM
 yeUExJBmxn1gZhZhic2nGozmzMgathNiV11L74fsuBHazD0Q+PO3i/5VkHZISi27y78gTOfBb
 D0teJxDNPCydV0cnTnsU2le646GZCe1BQubGJUVpWwmVckGCJnZ3YG+NgMibB+smgHPbk0Qwn
 oROXY3FkkQP1jra7nrR6IKWziVvbTXQs4oX5V5gLWFOnr48nODn34yGzi8X7Bt25XJvG2bxFp
 7vYtughz6cbQrL4SfMohoSQFsu1eoEsLM381uvDbRMgL61x/kPPrII5Mq3v3wITUro+zJLA+3
 ijcG8DKFG3CM/ioLuOftT/xgUjA+AJwZUwQXdkOenuo45vsbeCCH6ra2bI/oetc8FER5vvfqI
 rbS1xnN//uhWq7PglilGp9OkSsGrka8r2BiKyMDDqltOav9LvTGIU45skbVoM/9tbzPPkHw7C
 QLw8HV+9OmrGz0fVQHcihHXOwwqlkY6A6O7WjDpd0BF4HkN8lW9YmbfKpE+8fT32aPDmllGIY
 3X2uRv0b5F3+nHQKym/6KGvRSEEFziyPo/Cr6J1nDqaMXIwzDqRVSR0iwLeO9cnR7mUroBj0j
 7CYZy3I/XNMRNUwZdZ2uy2eCWqw/v3JpPaC1UaSdpeBT8z08lvIg573DTN97A58MDhtX3zLwu
 vr0Z5nsbH1/o2fd1H
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:18:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/+fhpLNQ1ii_a.pX8CXQEElE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
So here is v2. Patch 1 can already be merged independently of the others.

Regards,
Lukas Straub

Changes:
v2:
 -use new yank api
 -drop disk_size parameter
 -introduce pick_qemu_util function and use it

Overview:

Hello Everyone,
These patches introduce a resource agent for fully automatic management of =
colo
and a test suite building upon the resource agent to extensively test colo.

Test suite features:
-Tests failover with peer crashing and hanging and failover during checkpoi=
nt
-Tests network using ssh and iperf3
-Quick test requires no special configuration
-Network test for testing colo-compare
-Stress test: failover all the time with network load

Resource agent features:
-Fully automatic management of colo
-Handles many failures: hanging/crashing qemu, replication error, disk erro=
r, ...
-Recovers from hanging qemu by using the "yank" oob command
-Tracks which node has up-to-date data
-Works well in clusters with more than 2 nodes

Run times on my laptop:
Quick test: 200s
Network test: 800s (tagged as slow)
Stress test: 1300s (tagged as slow)

The test suite needs access to a network bridge to properly test the networ=
k,
so some parameters need to be given to the test run. See
tests/acceptance/colo.py for more information.

I wonder how this integrates in existing CI infrastructure. Is there a comm=
on
CI for qemu where this can run or does every subsystem have to run their own
CI?

Regards,
Lukas Straub


Lukas Straub (7):
  block/quorum.c: stable children names
  avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
  boot_linux.py: Use pick_qemu_util
  colo: Introduce resource agent
  colo: Introduce high-level test suite
  configure,Makefile: Install colo resource-agent
  MAINTAINERS: Add myself as maintainer for COLO resource agent

 MAINTAINERS                               |    6 +
 Makefile                                  |    5 +
 block/quorum.c                            |   20 +-
 configure                                 |   10 +
 scripts/colo-resource-agent/colo          | 1466 +++++++++++++++++++++
 scripts/colo-resource-agent/crm_master    |   44 +
 scripts/colo-resource-agent/crm_resource  |   12 +
 tests/acceptance/avocado_qemu/__init__.py |   15 +
 tests/acceptance/boot_linux.py            |   11 +-
 tests/acceptance/colo.py                  |  677 ++++++++++
 10 files changed, 2251 insertions(+), 15 deletions(-)
 create mode 100755 scripts/colo-resource-agent/colo
 create mode 100755 scripts/colo-resource-agent/crm_master
 create mode 100755 scripts/colo-resource-agent/crm_resource
 create mode 100644 tests/acceptance/colo.py

--
2.20.1

--Sig_/+fhpLNQ1ii_a.pX8CXQEElE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b68wACgkQNasLKJxd
sljzPA//ajofgsk+X808DLBslGh1tQb6/eNTeuunQeKD4aa+exP9J+N8uaxQHy8F
LXgJD5oBaQN0Yw9WvmcyiuiGgZLfFZHb0Z7q1h7gqAgs9xD8vQZUfvQWwKQz6xMl
ClMcDYYIjRcXcw50BElg9GIzO+PRmvf8DmgPiOsYEpAlqrOeTGR5AiAUNsGkJMMG
06Fl/hN5WSHTU0bvPYrndUu3umR+tYvsoqZqnh09dCUVq+rDAHB1BEBhXys3U5sm
HuTW6Zww+H8RVqR+RnTT/Zvxf10Vm9Hsleype4w4IawfgpG+WgnQ49BUj0kiZLXA
NsZ+bJz2edWuLMA7geHiVMp9YGTm6CTfKK8RHdepGUKjoRrdiNOqadFEFst9K4jJ
FUxdek2QdsAt9QRxvYzXJqlFjNKr6l6oyNcxQcahn2GW5BeZkg9b63DaqqWMGPjU
3t7kTTxgdZrSSc9HzpkrEfZn/qHwEV5Jhr8uEhRJDdLX/s89jKaGAtLLNU/teG0q
Pk9uplMq4OqNLdIW/n+6fkx0niIN94wzMPDkv52GMmWYS+RSETTWBKnMCiZzqJfe
tv76SnJUsruYw0ainbN9pLmr+3ghQO/1ahAAM/TBUCmEo4zraetdOK0+QYX0FGa6
s1M4XOr0fvYuvNat00oQkzyxS5vBmTnS1E2fQBsxbd/TzXd3pUg=
=t6Qz
-----END PGP SIGNATURE-----

--Sig_/+fhpLNQ1ii_a.pX8CXQEElE--

