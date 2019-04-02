Received: from eggs.gnu.org ([209.51.188.92]:36420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBKgj-0005n9-TO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBKgi-0002VP-UW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:46:57 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:47074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hBKgi-0002Tp-Mb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:46:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id t17so3980446wrw.13
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 07:46:55 -0700 (PDT)
References: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
	<20190402132846.GG413@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd916931-1d1f-50db-cb09-5f6a82b4fbba@redhat.com>
Date: Tue, 2 Apr 2019 16:46:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190402132846.GG413@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Unknown X11 keycode mapping report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Jean-Louis SOLATGES <jean-louis.solatges@wanadoo.fr>
Cc: qemu-devel@nongnu.org

On 4/2/19 3:28 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 02, 2019 at 02:47:25PM +0200, Jean-Louis SOLATGES wrote:
>> Bonjour, par tightvnc server sur clipper depuis un linux connecté en vncviewer,
> 
> Google translate doesn't do a good job here.

Google isn't that wrong here, I'm also having difficulties to understand.

> 
> Is this saying that you are running QEMU from inside a TightVNC server
> session running on Linux ?  IOW the X11 server would be Xvnc, not your
> regular desktop Xorg server ?

This is what I understand indeed.

Jean-Louis uses a Linux workstation where he uses vncviewer to connect
to a tightvnc server running on the 'clipper' server (Slackware 14.2).

Within the VNC session, he runs as root the qemu-system-x86_64 command
on 'clipper'. I suppose "Linux useit1 3.16.0-0.bpo.4-amd64" is the image
he tries to run.

>>
>> je lance :
>> qemu-system-x86_64 -m 16G -cpu kvm64 -accel kvm,thread=multi -smp 6,maxcpus=12 -net nic -net tap -net socket,listen=127.0.0.1:1234 -vga cirrus -boot c -hda uis1.img
> 
> 
> Can you say what version of QEMU you are using too ?
> 
> 
> Regards,
> Daniel
> 
