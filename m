Received: from eggs.gnu.org ([2001:4830:134:3::10]:49669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d98KE-0003Fu-5t
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d98KA-0005tz-CP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:01:34 -0400
Received: from mout.web.de ([212.227.15.4]:53068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elfring@users.sourceforge.net>)
	id 1d98KA-0005td-1m
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:01:30 -0400
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-2-f4bug@amsat.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e40b2b68-ec4e-f82a-452c-4898c7d3de90@users.sourceforge.net>
Date: Fri, 12 May 2017 13:00:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170512033543.6789-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

> +        print "  candidate", "IS" if is_optimizable else "is NOT", "optimizable"

I suggest to increase your software development attention also for
another detail here.

This information display is using the channel “sys.stdout”.
How do you think about to use the function “sys.stderr.write” (or an other
separate file) instead?

Regards,
Markus
