Received: from eggs.gnu.org ([209.51.188.92]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqt-00040z-5x
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyfqr-0004TG-Sv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:07 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyfqr-0004Ov-Bv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:45:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id w6so11460383wrs.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:45:02 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 16:44:54 +0000
Message-Id: <20190226164500.8080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 0/6] current state of gitdm/next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I had a few patches sat in my queue so I spent a little time doing
some email address archaeology and cleaning up the gitdm output. Some
of these are guesses so I won't be including them in a pull-request
until I get confirmation from the various contributors.

For reference the current contributor base for the last year looks
like:

  Top changeset contributors by employer
  Red Hat                   3181 (43.6%)
  Linaro                    1292 (17.7%)
  (None)                     414 (5.7%)
  IBM                        384 (5.3%)
  Academics (various)        257 (3.5%)
  Wave Computing             202 (2.8%)
  Virtuozzo                  170 (2.3%)
  Oracle                      89 (1.2%)
  Intel                       87 (1.2%)
  Cadence Design Systems      82 (1.1%)

The following patches need review
  0003/contrib gitdm add some more people academic group.patch
  0004/contrib gitdm add more individual contributors.patch
  0005/contrib gitdm another IBM email.patch
  0006/contrib gitdm another non corporate email from Re.patch

Aleksandar Markovic (2):
  contrib: gitdm: Update domain-map
  contrib: gitdm: Update Wave Computing group

Alex Bennée (4):
  contrib: gitdm: add some more people academic group
  contrib: gitdm: add more individual contributors
  contrib: gitdm: another IBM email
  contrib: gitdm: another non-corporate email from RedHat

 contrib/gitdm/domain-map            |  5 +++++
 contrib/gitdm/group-map-academics   |  9 +++++++++
 contrib/gitdm/group-map-ibm         |  1 +
 contrib/gitdm/group-map-individuals |  2 ++
 contrib/gitdm/group-map-redhat      |  1 +
 contrib/gitdm/group-map-wavecomp    | 12 ++++++++++++
 6 files changed, 30 insertions(+)

-- 
2.20.1
