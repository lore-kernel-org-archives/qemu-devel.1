Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo3U-0005Xz-RG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo3Q-0001zR-Tp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:31:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfo3Q-0001yQ-OH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:31:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487357968-31000-1-git-send-email-peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 14:30:57 +0100
In-Reply-To: <1487357968-31000-1-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Fri, 17 Feb 2017 18:59:28 +0000")
Message-ID: <8737f9xa3y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> Unfortunately some older versions of makeinfo don't correctly
> handle the -D command line option and fail to set the variable.
> This then causes them to complain
>  docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
>
> Work around this by doing as the autotools do, and writing
> the information into a version.texi file which we then
> include from the .texi files that need it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'll take this through my tree.  Thanks!
