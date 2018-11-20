Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP39B-0004C5-TC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP39A-0005TG-KF
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:45 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:42049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP399-0005S9-BH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:44 -0500
Received: by mail-oi1-x234.google.com with SMTP id w13so1042864oiw.9
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 02:20:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 10:20:21 +0000
Message-ID: <CAFEAcA_yFpdaXB2-Rj3no3ENf8gfukaE+kbqEe5J2xEdN+9wZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/12] NBD patches for 3.1-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 November 2018 at 17:54, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit e6ebbd46b6e539f3613136111977721d212c28=
12:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-11-19 14:31:48 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-11-19
>
> for you to fetch changes up to 8cedcffdc195bc39aeb1373826ba0a45629741e0:
>
>   iotests: Drop use of bash keyword 'function' (2018-11-19 11:16:46 -0600=
)
>
> There are still a couple of things I'm working on that might still
> qualify for 3.1, but given the timing of -rc2, it's getting more
> likely that they will shift into 4.0 instead:
> - handling of unaligned images (also broken in 3.0, so not necessarily
> a regression - but does fix assertion failures)
> - qemu-nbd command line option to query server's exports and info (would
> be new feature, but would make it a lot easier to test if existing
> x-dirty-block feature is working)
>
> Also, I did not spend enough time on this release reviewing Vladimir's
> additions for NBD reconnect, so that has now (sadly) slipped into 4.0.
>
> The diffstat touches a large number of files, which is rather awkward
> for an -rc2 pull request - but those changes are mostly mechanical
> and mostly in the iotests subdirectory. The changes to the code base
> proper are quite small.
>
> ----------------------------------------------------------------
> nbd patches for 2018-11-19
>
> Add iotest coverage for NBD connections using TLS, including
> a couple of code fixes that it pointed out
>
> - Mao Zhongyi: 0/3 Do some cleaning work in qemu-iotests
> - Daniel P. Berrang=C3=A9: io: return 0 for EOF in TLS session read after=
 shutdown
> - Daniel P. Berrang=C3=A9: 0/6 Misc fixes to NBD
> - Eric Blake: iotests: Drop use of bash keyword 'function'

Applied, thanks.

-- PMM
