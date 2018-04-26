Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkvN-0003Xm-1J
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkvK-0002Qw-Ey
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:43:17 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkvK-0002QS-6w
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:43:14 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23266.4013.789190.625834@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 18:43:09 +0100
In-Reply-To: <60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
	<60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] error reporting: Use
 error_report_errno in obvious places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel P.=?iso-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

Eric Blake writes ("Re: [RFC PATCH 3/7] error reporting: Use error_report_errno in obvious places"):
> Misses a lot of two-line instances, such as:
> $ git grep -A1 error_report | grep -C1 strerror.errno
> ...
...
> If we're going to clean up these instances, we might as well look harder
> for them.  Can Coccinelle be coaxed into helping us (at least for
> identifying callsites, even if I can't figure out how to make it
> slice-and-dice format strings)?

I have never used Coccinelle, so I don't know.

Ian.
