Received: from eggs.gnu.org ([209.51.188.92]:39349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13nH-000487-Eu
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13nG-00059N-OS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:43:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h13nG-000568-Hw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:43:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190304210217.7056-1-samuel.thibault@ens-lyon.org>
	<20190304210217.7056-3-samuel.thibault@ens-lyon.org>
Date: Tue, 05 Mar 2019 07:43:08 +0100
In-Reply-To: <20190304210217.7056-3-samuel.thibault@ens-lyon.org> (Samuel
	Thibault's message of "Mon, 4 Mar 2019 22:02:17 +0100")
Message-ID: <87zhq9x1mr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCHv2 2/2] curses: add option to specify VGA
 font encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, ekohler@gmail.com, kraxel@redhat.com, pbonzini@redhat.com

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> This uses iconv to convert glyphs from the specified VGA font encoding to
> unicode, and makes use of cchar_t instead of chtype when using ncursesw,
> which allows to store all wide char as well as the WACS values. The default
> charset is made CP437 since that is the charset of the hardware default VGA
> font. This also makes the curses backend set the LC_CTYPE locale to "" to
> allow curses to emit wide characters.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Eddie Kohler <ekohler@gmail.com>

For the QAPI / CLI part:
Acked-by: Markus Armbruster <armbru@redhat.com>
