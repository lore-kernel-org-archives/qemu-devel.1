Received: from eggs.gnu.org ([2001:4830:134:3::10]:55246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d95BJ-00058w-Qi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d95BE-0003Cu-Ur
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:40:09 -0400
Received: from mout.web.de ([212.227.15.4]:52326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elfring@users.sourceforge.net>)
	id 1d95BE-0003BF-Ki
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:40:04 -0400
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-2-f4bug@amsat.org>
	<alpine.DEB.2.20.1705121139030.2981@hadrien>
	<7d1b12cd-80dc-7fc8-935d-bec7fb08e256@amsat.org>
	<alpine.DEB.2.20.1705121513180.2981@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d89dcfa9-10a4-561d-7715-926d4930a7b6@users.sourceforge.net>
Date: Fri, 12 May 2017 09:39:17 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705121513180.2981@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/5] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Nicolas Palix <nicolas.palix@imag.fr>, Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

> Even for 6 functions, I would suggest to write out the function names in
> the pattern matching code rather than using regular expressions.  If the
> names are explicit, then Coccinelle can do some filtering, either based on
> an index made with idutils or glimpse (see the coccinelle scripts
> directory for tools for making these indices) or based on grep, to drop
> without parsing files that are not relevant.  It doesn't do this for
> regular expressions.  So you will get a faster result if the names are
> explicit in the pattern code.

Is such filtering performed for source file names?

I would find it more convenient to specify function prefixes as
regular expressions in constraints for the shown SmPL metavariables.

Regards,
Markus
