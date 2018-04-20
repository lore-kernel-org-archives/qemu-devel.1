Received: from eggs.gnu.org ([2001:4830:134:3::10]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=641335876=Ian.Jackson@citrix.com>)
	id 1f9T95-0007V9-F3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=641335876=Ian.Jackson@citrix.com>)
	id 1f9T92-00016k-AY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:19:59 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:39040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=641335876=Ian.Jackson@citrix.com>)
	id 1f9T92-00013w-2E
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:19:56 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-ID: <23257.48838.736085.250541@mariner.uk.xensource.com>
Date: Fri, 20 Apr 2018 11:19:50 +0100
In-Reply-To: <f594f663-d53c-690e-8797-48cbbe43f8fa@amsat.org>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-15-git-send-email-ian.jackson@eu.citrix.com>
	<f594f663-d53c-690e-8797-48cbbe43f8fa@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 14/16] os-posix: cleanup: Replace fprintf
 with error_report in remaining call sites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Philippe Mathieu-Daudé writes ("Re: [Qemu-devel] [PATCH 14/16] os-posix: cleanup: Replace fprintf with error_report in remaining call sites"):
> On 04/19/2018 01:45 PM, Ian Jackson wrote:
> > -    fprintf(stderr, "Change of process name not supported by your OS\n");
> > +    error_report("Change of process name not supported by your OS\n");
> 
> removing the trailing "\n":
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Damn, missed one!  Thanks :-).

Ian.
