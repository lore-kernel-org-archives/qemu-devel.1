Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C91207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C91207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHYB-00063P-Ik
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBHWd-0004cK-HU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:47062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBHWW-00019J-SL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kBHWU-0005zw-IF
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 13:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 882C72E806E
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 13:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2020 12:55:31 -0000
From: Guirish Salgaonkar <1893040@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange gsalgaon
X-Launchpad-Bug-Reporter: Guirish Salgaonkar (gsalgaon)
X-Launchpad-Bug-Modifier: Guirish Salgaonkar (gsalgaon)
References: <159844225257.1396.12890490778938419036.malonedeb@wampee.canonical.com>
Message-Id: <159853293164.16164.4968928964111959420.malone@soybean.canonical.com>
Subject: [Bug 1893040] Re: External modules retreval using Go1.15 on s390x
 appears to have checksum and ECDSA verification issues
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 03d7b48d9754a9e912abda4350ffc14f573ba5ef
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:20:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1893040 <1893040@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We followed below steps to reproduce the error:

1) Create new folder =

$ mkdir -p example.com/hello
$ cd example.com/hello

2) Create file hello.go as below;
$ cat hello.go
package main
import (
    "fmt"
    "rsc.io/quote"
)
func main() {
    fmt.Println(quote.Hello())
}

3) Create file go.mod as below
$ cat go.mod
module example.com/hello
go 1.15

4) Create Dockerfile as below:
$ cat Dockerfile
# Build the manager binary
FROM golang:1.15
WORKDIR /workspace
# Copy the sources
COPY hello.go ./
COPY go.mod ./
# Allow fallback to 'direct' for GOPROXY
#
# The GOPROXY environment variable now supports skipping proxies that return
# errors. Proxy URLs may now be separated with either commas (,) or pipe
# characters (|). If a proxy URL is followed by a comma, the go command will
# only try the next proxy in the list after a 404 or 410 HTTP response. If a
# proxy URL is followed by a pipe character, the go command will try the ne=
xt
# proxy in the list after any error. Note that the default value of GOPROXY
# remains https://proxy.golang.org,direct, which does not fall back to dire=
ct
# in case of errors.
#
# ref: https://golang.org/doc/go1.15#go-command
ENV GOPROXY=3D"https://proxy.golang.org|direct"
RUN go env

# Cache the go build
RUN go build .

5) Register QEMU and create buildx instance
$ docker run --rm --privileged multiarch/qemu-user-static@sha256:c772ee1965=
aa0be9915ee1b018a0dd92ea361b4fa1bcab5bbc033517749b2af4 --reset -p yes
$ docker buildx create --name multiarch-go-runner --use

6) Error observed while building image
$ docker buildx build --load --progress plain --platform linux/s390x -t go_=
chk3 .
#1 [internal] booting buildkit
#1 pulling image moby/buildkit:buildx-stable-1
#1 pulling image moby/buildkit:buildx-stable-1 1.4s done
#1 creating container buildx_buildkit_multiarch-go-runner0
#1 creating container buildx_buildkit_multiarch-go-runner0 1.3s done
#1 DONE 2.7s
#2 [internal] load .dockerignore
#2 transferring context: 2B done
#2 DONE 0.1s
#3 [internal] load build definition from Dockerfile
#3 transferring dockerfile: 1.50kB done
#3 DONE 0.1s
#4 [internal] load metadata for docker.io/library/golang:1.15
#4 DONE 4.1s
#7 [internal] load build context
#7 transferring context: 206B done
#7 DONE 0.1s
#5 [1/6] FROM docker.io/library/golang:1.15@sha256:4c3279e05a0131c0565466ac=
...
#5 resolve docker.io/library/golang:1.15@sha256:4c3279e05a0131c0565466ac538=
755f104d8d936efbc4c30ba7d717c73f3e2c2 done
#5 sha256:4c3279e05a0131c0565466ac538755f104d8d936efbc4c30ba7d717c73f3e2c2 =
2.36kB / 2.36kB done
#5 sha256:c5e175e434734f93e9b75f245f05578e7a12cedffed20cae845f57a3c7139b95 =
0B / 155B 0.1s
#5 sha256:f2b199a6d9adcfa5f879ec8042306ab2f919623f8018d0d7a6f4e9dade5e1a71 =
0B / 48.97MB 0.1s
#5 sha256:5615f13ce6c82698ac5df02b39113e3a8949db1a7a7f7f5d07c9265ee15b79d0 =
0B / 7.39MB 0.1s
#5 sha256:8ee3c4544ee6e2d4cd23f1b47d6fde1775c25fab9a77851b118074afa00c9f4f =
1.79kB / 1.79kB done
#5 sha256:356049cf27ce547d544a426484dee88b17a1abb2c51e359a15c3565b2f0d33f0 =
6.18kB / 6.18kB done
#5 sha256:23ffecb808bd421be3db88ff08f67b19f28c1ffe0d4c157be3fcff3360f527bc =
0B / 9.88MB 0.1s
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
0B / 56.74MB 0.1s
#5 sha256:44e2ce491a55134d5e4118405670fcc19b140898dc8ac62156e47a49f52e9f2d =
0B / 51.38MB 0.3s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
0B / 101.17MB 0.3s
#5 sha256:c5e175e434734f93e9b75f245f05578e7a12cedffed20cae845f57a3c7139b95 =
155B / 155B 1.6s done
#5 sha256:5615f13ce6c82698ac5df02b39113e3a8949db1a7a7f7f5d07c9265ee15b79d0 =
3.16MB / 7.39MB 1.8s
#5 sha256:23ffecb808bd421be3db88ff08f67b19f28c1ffe0d4c157be3fcff3360f527bc =
1.75MB / 9.88MB 1.8s
#5 sha256:f2b199a6d9adcfa5f879ec8042306ab2f919623f8018d0d7a6f4e9dade5e1a71 =
19.48MB / 48.97MB 2.1s
#5 sha256:5615f13ce6c82698ac5df02b39113e3a8949db1a7a7f7f5d07c9265ee15b79d0 =
7.39MB / 7.39MB 1.9s done
#5 sha256:23ffecb808bd421be3db88ff08f67b19f28c1ffe0d4c157be3fcff3360f527bc =
9.88MB / 9.88MB 1.9s done
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
20.79MB / 56.74MB 2.1s
#5 sha256:44e2ce491a55134d5e4118405670fcc19b140898dc8ac62156e47a49f52e9f2d =
19.40MB / 51.38MB 2.1s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
19.54MB / 101.17MB 2.1s
#5 sha256:f2b199a6d9adcfa5f879ec8042306ab2f919623f8018d0d7a6f4e9dade5e1a71 =
37.71MB / 48.97MB 2.4s
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
35.35MB / 56.74MB 2.4s
#5 sha256:44e2ce491a55134d5e4118405670fcc19b140898dc8ac62156e47a49f52e9f2d =
38.91MB / 51.38MB 2.4s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
39.22MB / 101.17MB 2.4s
#5 sha256:f2b199a6d9adcfa5f879ec8042306ab2f919623f8018d0d7a6f4e9dade5e1a71 =
45.15MB / 48.97MB 2.5s
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
43.24MB / 56.74MB 2.5s
#5 sha256:44e2ce491a55134d5e4118405670fcc19b140898dc8ac62156e47a49f52e9f2d =
47.92MB / 51.38MB 2.5s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
48.30MB / 101.17MB 2.5s
#5 sha256:f2b199a6d9adcfa5f879ec8042306ab2f919623f8018d0d7a6f4e9dade5e1a71 =
48.97MB / 48.97MB 2.7s done
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
56.74MB / 56.74MB 2.8s
#5 sha256:44e2ce491a55134d5e4118405670fcc19b140898dc8ac62156e47a49f52e9f2d =
51.38MB / 51.38MB 2.7s done
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
66.70MB / 101.17MB 2.8s
#5 sha256:e060fbdc544cffa8f72ebc5c629d0fd77e9f0ea787a2eec80f4a77dd0833d747 =
56.74MB / 56.74MB 3.0s done
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
77.91MB / 101.17MB 3.0s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
88.63MB / 101.17MB 3.1s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
99.91MB / 101.17MB 3.3s
#5 sha256:69157c3b9bc7dad5a676fdc6700b95a1a9dbcffc7ccfb7cd20d91f16be6e9ffd =
101.17MB / 101.17MB 3.6s done
#5 unpacking docker.io/library/golang:1.15@sha256:4c3279e05a0131c0565466ac5=
38755f104d8d936efbc4c30ba7d717c73f3e2c2
#5 unpacking docker.io/library/golang:1.15@sha256:4c3279e05a0131c0565466ac5=
38755f104d8d936efbc4c30ba7d717c73f3e2c2 17.8s done
#5 DONE 22.8s
#6 [2/6] WORKDIR /workspace
#6 DONE 2.6s
#8 [3/6] COPY hello.go ./
#8 DONE 0.2s
#9 [4/6] COPY go.mod ./
#9 DONE 0.1s
#10 [5/6] RUN go env
#10 1.711 GO111MODULE=3D""
#10 1.711 GOARCH=3D"s390x"
#10 1.711 GOBIN=3D""
#10 1.711 GOCACHE=3D"/root/.cache/go-build"
#10 1.711 GOENV=3D"/root/.config/go/env"
#10 1.711 GOEXE=3D""
#10 1.711 GOFLAGS=3D""
#10 1.711 GOHOSTARCH=3D"s390x"
#10 1.712 GOHOSTOS=3D"linux"
#10 1.712 GOINSECURE=3D""
#10 1.712 GOMODCACHE=3D"/go/pkg/mod"
#10 1.712 GONOPROXY=3D""
#10 1.712 GONOSUMDB=3D""
#10 1.712 GOOS=3D"linux"
#10 1.712 GOPATH=3D"/go"
#10 1.713 GOPRIVATE=3D""
#10 1.713 GOPROXY=3D"https://proxy.golang.org|direct"
#10 1.713 GOROOT=3D"/usr/local/go"
#10 1.713 GOSUMDB=3D"sum.golang.org"
#10 1.713 GOTMPDIR=3D""
#10 1.713 GOTOOLDIR=3D"/usr/local/go/pkg/tool/linux_s390x"
#10 1.713 GCCGO=3D"gccgo"
#10 1.713 AR=3D"ar"
#10 1.713 CC=3D"s390x-linux-gnu-gcc"
#10 1.713 CXX=3D"g++"
#10 1.713 CGO_ENABLED=3D"1"
#10 1.713 GOMOD=3D"/workspace/go.mod"
#10 1.714 CGO_CFLAGS=3D"-g -O2"
#10 1.714 CGO_CPPFLAGS=3D""
#10 1.714 CGO_CXXFLAGS=3D"-g -O2"
#10 1.714 CGO_FFLAGS=3D"-g -O2"
#10 1.714 CGO_LDFLAGS=3D"-g -O2"
#10 1.714 PKG_CONFIG=3D"pkg-config"
#10 1.714 GOGCCFLAGS=3D"-fPIC -m64 -march=3Dz196 -pthread -fmessage-length=
=3D0 -fdebug-prefix-map=3D/tmp/go-build803398483=3D/tmp/go-build -gno-recor=
d-gcc-switches"
#10 DONE 1.8s
#11 [6/6] RUN go build .
#11 0.567 go: finding module for package rsc.io/quote
#11 8.056 go: downloading rsc.io/quote v1.5.2
#11 9.080 hello.go:5:5: rsc.io/quote@v1.5.2: verifying module: rsc.io/quote=
@v1.5.2: Get "https://sum.golang.org/lookup/rsc.io/quote@v1.5.2": tls: inva=
lid signature by the server certificate: ECDSA verification failure
#11 ERROR: executor failed running [/bin/sh -c go build .]: buildkit-runc d=
id not terminate successfully
------
 > [6/6] RUN go build .:
------
failed to solve: rpc error: code =3D Unknown desc =3D executor failed runni=
ng [/bin/sh -c go build .]: buildkit-runc did not terminate successfully

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893040

Title:
   External modules retreval using Go1.15 on s390x appears to have
  checksum and ECDSA verification issues

Status in QEMU:
  Incomplete

Bug description:
  We are observing issue while building go-runner image and we suspect it i=
s due to QEMU version being used. As referred in below issue:
  https://github.com/golang/go/issues/40949

  We tried to build go-runner image using go1.15 and register QEMU
  (docker run --rm --privileged multiarch/qemu-user-
  static@sha256:c772ee1965aa0be9915ee1b018a0dd92ea361b4fa1bcab5bbc033517749=
b2af4
  --reset -p yes) as mentioned in PR
  https://github.com/kubernetes/release/pull/1499. We observed below
  failure during build:

  -------------------------------------------------------------------------=
--------
  ERROR: executor failed running [/bin/sh -c CGO_ENABLED=3D0 GOOS=3Dlinux G=
OARCH=3D${ARCH}     go build -ldflags '-s -w -buildid=3D -extldflags "-stat=
ic"'     -o go-runner ${package}]: buildkit-runc did not terminate successf=
ully
  ------
  =C2=A0> [builder 7/7] RUN CGO_ENABLED=3D0 GOOS=3Dlinux GOARCH=3D${ARCH}  =
   go build -ldflags '-s -w -buildid=3D -extldflags "-static"'     -o go-ru=
nner .:
  ------
  failed to solve: rpc error: code =3D Unknown desc =3D executor failed run=
ning [/bin/sh -c CGO_ENABLED=3D0 GOOS=3Dlinux GOARCH=3D${ARCH}     go build=
 -ldflags '-s -w -buildid=3D -extldflags "-static"'     -o go-runner ${pack=
age}]: buildkit-runc did not terminate successfully
  Makefile:52: recipe for target 'container' failed
  make: *** [container] Error 1
  -------------------------------------------------------------------------=
--------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893040/+subscriptions

