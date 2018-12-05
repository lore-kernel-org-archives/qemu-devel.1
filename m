Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUWxY-0006DQ-36
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUWxR-0003tZ-Th
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:11:24 -0500
Received: from indium.canonical.com ([91.189.90.7]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gUWxN-0003r1-Mo
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:11:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gUWxJ-00032w-0X
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 13:11:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED8A52E80CF
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 13:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Dec 2018 13:03:44 -0000
From: johann peyrard <1801933@bugs.launchpad.net>
Reply-To: Bug 1801933 <1801933@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154151022459.20108.13605520748922076387.malonedeb@gac.canonical.com>
	<154400883834.616.14516855657300569326.malone@chaenomeles.canonical.com>
Message-Id: <CAE9HAuFxSPd6aUcD2wi-gfkSB-EdE+4V8f8CjpN-_aaS11B9Xg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1801933] Re: default memory parameter too
 small on x86_64 today
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Daniel,

I use qemu for a long time now so for me it's easier to use than any other
solution.
I think I began to use as my preffered VM tool in 2003.
But, I still think that keeping this value at 128MB is low today.
Maybe in this case reducing this value to make it crash is another option,
for example 4MB.
Or just print a message if it is an iso file that ramsize is set to 128MB,
maybe you need more ram.
It is just quick thought, some OS will handle this correctly, some os won't.
For example in my example I say that debian say it explicitely in the 80x25
screen in red.

Today I see all people around me are moving to VirtualBox because it just
work out of the box.
And Qemu is near to work out of the box with 2 or 3 parameter in the end.
Definitely I have a prefference for Qemu, because it's more "shell
friendly".

It was just my quick thought about it.

Johann


Le mer. 5 d=C3=A9c. 2018 =C3=A0 12:31, Daniel Berrange <1801933@bugs.launch=
pad.net> a
=C3=A9crit :

> IMHO, if achieving ease of use comparable to VirtualBox is your
> benchmark target, then launching QEMU directly is really the wrong way
> to approach things. QEMU is a very low level piece of infrastructure not
> a complete end user desktop solution. For that it is better to look at
> using an application such as virt-manager, or GNOME Boxes. These provide
> higher level solution over QEMU and do smart things during installation,
> using libosinfo to automatically determine the best memory, disk,
> network, etc settings for each particular guest OS rather than relying
> on some hardcoded defaults.
>
> That said all said, I don't rule out that we could change our memory
> defaults, but picking an optimal value is hard. Even 500 MB is
> considered to be unsupported from a RHEL-7 pov - the documented minimum
> for RHEL-7 is 1 GB per vCPU. The installer is quite likely to crash with
> 500 MB depending on what options you select durin intsall.
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1801933
>
> Title:
>   default memory parameter too small on x86_64 today
>
> Status in QEMU:
>   New
>
> Bug description:
>   Launching a centos74 iso VM today does not work anymore on x86_64
>   without increasing the size of the memory parameter. For example with
>   this command :
>
>   $ /opt/qemu-3.0.0/bin/qemu-system-x86_64 --curses   -enable-kvm -drive
>   file=3Dfile.dd,index=3D0,media=3Ddisk -drive file=3Dcentos-
>   x86_64.iso,index=3D1,media=3Dcdrom
>
>   [    3.047614] Failed to execute /init
>   [    3.048315] Kernel panic - not syncing: No init found.  Try passing
> init=3D option to kernel. See Linux Documentation/init.txt for guidance.
>   [    3.049258] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.10.0-693.21.1.el7.x86
>
>   Increasing the size from the default 128MiB to 512MiB let the VM works
> without problem.
>   So, ok, it's not a qemu problem, it's more a "User problem" and
> interface problem for me.
>   But it push me in the end to launch VirtualBox instead of qemu, because
> the default parameter does not work anymore... And I had no time to
> investigate why it does not work because the message is not visible.
>   Debian iso with the same command line for example show a message to tell
> me that there is not enough memory, so it help me to track the real issue
> behind.
>
>   But... In the end, I think today, the default memory parameter on x86_64
> is too small and it can lead some people like me to switch to VirtualBox.
>   VirtualBox, in the wizard is set by default to 4MiB Ram size, which tell
> you... Ok I need to put more. And, you know that 4MiB is not enough in the
> end.
>
>   Regards,
>
>   Johann
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1801933/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1801933

Title:
  default memory parameter too small on x86_64 today

Status in QEMU:
  New

Bug description:
  Launching a centos74 iso VM today does not work anymore on x86_64
  without increasing the size of the memory parameter. For example with
  this command :

  $ /opt/qemu-3.0.0/bin/qemu-system-x86_64 --curses   -enable-kvm -drive
  file=3Dfile.dd,index=3D0,media=3Ddisk -drive file=3Dcentos-
  x86_64.iso,index=3D1,media=3Dcdrom

  [    3.047614] Failed to execute /init
  [    3.048315] Kernel panic - not syncing: No init found.  Try passing in=
it=3D option to kernel. See Linux Documentation/init.txt for guidance.
  [    3.049258] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-693.21.1.=
el7.x86

  Increasing the size from the default 128MiB to 512MiB let the VM works wi=
thout problem.
  So, ok, it's not a qemu problem, it's more a "User problem" and interface=
 problem for me.
  But it push me in the end to launch VirtualBox instead of qemu, because t=
he default parameter does not work anymore... And I had no time to investig=
ate why it does not work because the message is not visible.
  Debian iso with the same command line for example show a message to tell =
me that there is not enough memory, so it help me to track the real issue b=
ehind.

  But... In the end, I think today, the default memory parameter on x86_64 =
is too small and it can lead some people like me to switch to VirtualBox.
  VirtualBox, in the wizard is set by default to 4MiB Ram size, which tell =
you... Ok I need to put more. And, you know that 4MiB is not enough in the =
end.

  Regards,

  Johann

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1801933/+subscriptions
