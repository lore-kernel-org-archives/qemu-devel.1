Received: from eggs.gnu.org ([2001:4830:134:3::10]:54145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBfRp-0006vB-9j
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBfRk-0000jY-DX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:52:25 -0400
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
Date: Thu, 26 Apr 2018 13:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 26/04/2018 10:17, Peter Maydell wrote:
> I've now made the switch to homebrew, and so my OSX build tests
> will be using glib 2.56. NB that this means that none of my merge
> testing will catch "glib version too old" for our current setting
> of "too old" -- I'm not sure what my current oldest version is in
> the test machine set.

The min-glib Dockerfile is using glib 2.22 (on CentOS 6).  The CentOS 6
build is using 2.28.

Paolo
