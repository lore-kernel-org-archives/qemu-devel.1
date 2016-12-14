Received: from eggs.gnu.org ([2001:4830:134:3::10]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH35x-0003y3-Lp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH35u-0004gS-Fm
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:31:17 -0500
Received: from mail.weilnetz.de ([37.221.199.173]:37722)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH35u-0004g9-9K
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:31:14 -0500
References: <CAJSP0QUn4OE3_9foGgktt5O_KzrEzV8uhB1mpoS1q5x4DsPTPQ@mail.gmail.com>
	<CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
	<CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
	<c246423e-d62b-1572-341d-3a1933e496fa@weilnetz.de>
	<CAJSP0QW-Mv8N=aULWeXfMQa08DBEC9GPCOnsw6iPiSF_kb3s+g@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <cbc002df-9a0a-613d-f4c3-03de1047be09@weilnetz.de>
Date: Wed, 14 Dec 2016 07:31:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QW-Mv8N=aULWeXfMQa08DBEC9GPCOnsw6iPiSF_kb3s+g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU po files / translations (was: Any QEMU 2.8
 release blockers?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 12/13/16 22:52, Stefan Hajnoczi wrote:
> I've sent a patch to the list and CCed you.  I ran make -C po update.
>
> Weird that the line numbers are hardcoded in the .po file format.  An
> addr2line type tool would have been better to avoid the constant
> outdated line numbers.  That said, I don't know anything about how
> gettext is designed...

xgettext has an optional parameter --no-location which suppresses
the comments with filename:line.

All QEMU texts currently come from gtk.c, so that information
is not very useful. We could try running with --no-location
for the next release.

Even then the po files need a little bit more maintenance:
several texts don't have translations. And of course there
are more strings than those in gtk.c which could be translated,
e. g. the help texts, monitor output, error messages, ...

Stefan
