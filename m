Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2496C20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2496C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUMz-0006Sc-DD
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdUMH-0005qZ-MI
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:38476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdUMG-0001mi-97
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdUME-0006ur-4G
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1EEF12E8048
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2020 07:37:06 -0000
From: Rajas Kakodkar <1880518@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier rajaskakodkar
X-Launchpad-Bug-Reporter: Rajas Kakodkar (rajaskakodkar)
X-Launchpad-Bug-Modifier: Rajas Kakodkar (rajaskakodkar)
References: <159039304634.8018.14704731502559290875.malonedeb@gac.canonical.com>
Message-Id: <159047862675.20620.15711660388817638757.malone@soybean.canonical.com>
Subject: [Bug 1880518] Re: issue while installing docker inside s390x container
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0adff6e808edb0dd5c76359759631b393b3606ae
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 03:50:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1880518 <1880518@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error message that I posted above is all that I see when I go to pull a=
nd image.
Following is the log from docker daemon

time=3D"2020-05-26T07:34:31.385796553Z" level=3Dinfo msg=3D"API listen on /=
var/run/docker.sock"
time=3D"2020-05-26T07:34:34.607431981Z" level=3Ddebug msg=3D"Calling GET /_=
ping"
time=3D"2020-05-26T07:34:34.635096021Z" level=3Ddebug msg=3D"Calling GET /v=
1.38/containers/json"
time=3D"2020-05-26T07:34:43.919894850Z" level=3Ddebug msg=3D"Calling GET /_=
ping"
time=3D"2020-05-26T07:34:43.963634642Z" level=3Ddebug msg=3D"Calling GET /v=
1.38/info"
time=3D"2020-05-26T07:34:44.702451808Z" level=3Ddebug msg=3D"Calling POST /=
v1.38/images/create?fromImage=3Dhello-world&tag=3Dlatest"
time=3D"2020-05-26T07:34:44.715857621Z" level=3Ddebug msg=3D"Trying to pull=
 hello-world from https://registry-1.docker.io v2"
time=3D"2020-05-26T07:34:46.805807639Z" level=3Ddebug msg=3D"Pulling ref fr=
om V2 registry: hello-world:latest"
time=3D"2020-05-26T07:34:46.806872106Z" level=3Ddebug msg=3D"docker.io/libr=
ary/hello-world:latest resolved to a manifestList object with 9 entries; lo=
oking for a unknown/s390x match"
time=3D"2020-05-26T07:34:46.808815074Z" level=3Ddebug msg=3D"found match fo=
r linux/s390x with media type application/vnd.docker.distribution.manifest.=
v2+json, digest sha256:e49abad529e5d9bd6787f3abeab94e09ba274fe34731349556a8=
50b9aebbf7bf"
time=3D"2020-05-26T07:34:47.233545931Z" level=3Ddebug msg=3D"pulling blob \=
"sha256:3c80930bfdd5b53b7ca2a6b8116ed9a273af43a6b2dd13e81e82aae7521be469\""
time=3D"2020-05-26T07:34:47.864739182Z" level=3Ddebug msg=3D"Downloaded 3c8=
0930bfdd5 to tempfile /var/lib/docker/tmp/GetImageBlob114078888"
time=3D"2020-05-26T07:34:48.038875327Z" level=3Ddebug msg=3D"Cleaning up la=
yer b3da5d545c61d65059a2190feb19ae13797338ee999542b615e93e9708b88507: Error=
 processing tar file(exit status 1): "
time=3D"2020-05-26T07:34:48.049928529Z" level=3Dinfo msg=3D"Attempting next=
 endpoint for pull after error: failed to register layer: Error processing =
tar file(exit status 1): "

Since I am using multiarch/qemu-user-static with the latest tag, qemu
version is 4.2.0-6.

docker in docker works flawlessly on native s390x host. I am facing this
issue only with qemu. Are there any other steps to follow to make docker
in docker work under qemu?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880518

Title:
  issue while installing docker inside s390x container

Status in QEMU:
  New

Bug description:
  This is in reference to https://github.com/multiarch/qemu-user-static/iss=
ues/108.
  I am facing issue while installing docker inside s390x container under qe=
mu on Ubuntu 18.04 host running on amd64.
  Following are the contents of /proc/sys/fs/binfmt_misc/qemu-s390x on Inte=
l host after running =

  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  enabled
  interpreter /usr/bin/qemu-s390x-static
  flags: F
  offset 0
  magic 7f454c4602020100000000000000000000020016
  mask ffffffffffffff00fffffffffffffffffffeffff
  I could get docker service up with the following trick. =

  printf '{"iptables": false,"ip-masq": false,"bridge": "none" }' > /etc/do=
cker/daemon.json
  But even though docker service comes up, images are not getting pulled, d=
ocker pull fails with the following error.
  failed to register layer: Error processing tar file(exit status 1):

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880518/+subscriptions

