Received: from eggs.gnu.org ([2001:4830:134:3::10]:34340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3242cc1be=anthony.perard@citrix.com>)
	id 1dIe1W-0002Jm-8g
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3242cc1be=anthony.perard@citrix.com>)
	id 1dIe1T-00010H-4W
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:34 -0400
Received: from smtp.citrix.com ([66.165.176.89]:7680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3242cc1be=anthony.perard@citrix.com>)
	id 1dIe1S-0000zm-UT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:31 -0400
Date: Wed, 7 Jun 2017 17:41:16 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170607164115.GE1919@perard.uk.xensource.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170529084546.26500-12-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/14] char: move CharBackend handling
 in char-fe unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, f4bug@amsat.org, xen-devel@lists.xen.org

On Mon, May 29, 2017 at 12:45:43PM +0400, Marc-André Lureau wrote:
> Move all the fronted struct and methods to a seperate unit. This avoids
> accidentally mixing backend and frontend calls, and helps with readibilty.
> 
> Make qemu_chr_replay() a macro shared by both char and char-fe.
> 
> Export qemu_chr_write(), and use a macro for qemu_chr_write_all()
> 
> (nb: yes, CharBackend is for char frontend :)

Hi Marc-André,

Following this patch, we are not able anymore to launch QEMU with
-monitor /dev/null.
> qemu-system-i386: -monitor /dev/null: 'tty' is not a valid char driver name

FYI, the full command line used:
/usr/lib/xen/bin/qemu-system-i386 -xen-domid 0 \
    -xen-attach -name dom0 -nographic -M xenpv -daemonize \
    -monitor /dev/null -serial /dev/null -parallel /dev/null \
    -nodefaults -no-user-config \
    -pidfile /var/run/xen/qemu-dom0.pid

Regards,

-- 
Anthony PERARD
