Received: from eggs.gnu.org ([209.51.188.92]:40187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyi2S-0008PX-JC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyi2Q-0002H6-Qn
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:05:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyi2Q-000200-8v
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:05:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id t206so11269686oib.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20190225123111.30363-1-berrange@redhat.com>
In-Reply-To: <20190225123111.30363-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 19:04:24 +0000
Message-ID: <CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Merge authz core patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Mon, 25 Feb 2019 at 12:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be1=
16:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201902=
21.0' into staging (2019-02-22 15:48:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/authz-core-pull-request
>
> for you to fetch changes up to cfde05c6c0db7d3122a5491d50f62f7910ab8abb:
>
>   authz: delete existing ACL implementation (2019-02-25 12:28:25 +0000)
>
> ----------------------------------------------------------------
> Add a standard authorization framework
>
> The current network services now support encryption via TLS and in some
> cases support authentication via SASL. In cases where SASL is not
> available, x509 client certificates can be used as a crude authorization
> scheme, but using a sub-CA and controlling who you give certs to. In
> general this is not very flexible though, so this series introduces a
> new standard authorization framework.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
