Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gNbd2-0000Rf-1m
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gNbcy-0002cy-TW
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:45:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gNbcy-0002Op-Gr
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:45:32 -0500
Message-ID: <6229b5afb0c5a0db62ee4e4bdd6669afc24ac628.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 16 Nov 2018 11:45:07 +0100
In-Reply-To: <20181116050134.GA16550@xz-x1>
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
	<CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
	<20181116050134.GA16550@xz-x1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>
Cc: Ilya Maximets <i.maximets@samsung.com>, Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, armbru@redhat.com

On Fri, 2018-11-16 at 13:01 +0800, Peter Xu wrote:
> On Thu, Nov 15, 2018 at 08:24:23PM -0700, Warner Losh wrote:
> > I'm coming to the game late...
> > 
> > I run FreeBSD in qemu all the time, but I build images from source to test
> > the boot loader and it's all serial and my test scripts are tuned to that.
> > I rarely use the pre-built images, however.
> > 
> > If there's ways that we can build images that work better than we're doing
> > right now to make the experience better, like making sure we enable the
> > dual console support for them... We're late in our release cycle, but if
> > what we need to change is what I think we need to change, we still have
> > time for it.
> > 
> > In the mean time I'll read through wiki and see if there's anything
> > obviously wrong...
> 
> I would guess there aren't many people like me to prefer booting a VM
> using console, though I agree that it'll be nice if we put something
> into the prebuilt images like what's suggested by Ilya (and so far I
> don't see anything bad with that):
> 
>         [root@freebsd ~]# cat /boot/loader.conf
>         boot_multicons="YES"
>         boot_serial="YES"
>         comconsole_speed="115200"
>         console="comconsole,vidconsole"
> 
> Anyway, thanks for your work on either the wiki or the images, they
> are really helpful to people like me.

We use the official qcow2 images for FreeBSD for libvirt/virt-tools
CI[1] and not having serial console/ssh access by default is a bit
annoying, as it requires the administrator/developer to log in using
the graphical console, configure the guest OS according to [2], run
an Ansible playbook which, among other things, will enable serial
console access[3], and finally remove the graphical console.

If official qcow2 images could have serial console access turned on
by default, that would make the process a lot more convenient for us.

Just another data point :)


[1] https://ci.centos.org/view/libvirt/
[2] https://github.com/libvirt/libvirt-jenkins-ci/blob/master/guests/README.markdown#freebsd
[3] https://github.com/libvirt/libvirt-jenkins-ci/blob/master/guests/playbooks/update/tasks/bootloader.yml#L41-L51
-- 
Andrea Bolognani / Red Hat / Virtualization
