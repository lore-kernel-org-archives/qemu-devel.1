Received: from eggs.gnu.org ([2001:4830:134:3::10]:51698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7LNG-0003ho-9H
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7LNC-0008Hx-9S
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:05:34 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:54242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7LNC-0008GT-3k
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:05:30 -0400
Received: by mail-qt0-x22d.google.com with SMTP id n61so34589779qte.10
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 06:05:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ce3317d-8833-7e2e-9b4d-93acb45317a1@amsat.org>
Date: Wed, 25 Oct 2017 10:05:15 -0300
MIME-Version: 1.0
In-Reply-To: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Merge tpm 2017/10/24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

Hi Stefan,

On 10/25/2017 02:14 AM, Stefan Berger wrote:
> *The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-24-1
> 
> for you to fetch changes up to 298d8b81d45d2297f88d93604bd5eebfd653d6cf:

The tag is correct,

  $ git tag -v pull-tpm-2017-10-24-1
  tag pull-tpm-2017-10-24-1
  tagger Stefan Berger <stefanb@linux.vnet.ibm.com> 1508908015 -0400
  gpg: Good signature from "Stefan Berger <stefanb@linux.vnet.ibm.com>"
  Merge tpm 2017/10/24 v1

However you sent it as a PATCH series, I'm not sure this will correctly
trigger Peter's farm-building scripts.

Also I suggest you to add some description such "This fixes a build
issue using --disable-tpm" in the cover letter.

Regards,

Phil.
