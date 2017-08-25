Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dl9s3-0001L2-9I
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dl9rz-0007L6-AR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dl9rz-0007Kx-3f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:21:35 -0400
References: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ebe4b0f3-9b50-2fc8-6238-d40f32d6e0b3@redhat.com>
Date: Fri, 25 Aug 2017 10:21:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Why got no response of vnc?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>, qemu-devel@nongnu.org

On 25.08.2017 08:31, Sam wrote:
> Hi all,
> 
> I'm starting vm using:
> 
> kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2 -cdrom
>> CentOS-7-x86_64-DVD-1503-01.iso -boot d
>> VNC server running on '127.0.0.1:5900'
> 
> then I start vnc client in another PC to connect 10.253.23.24:11800 and
> 10.253.23.24:5900, I got time out, why?

Do you have a firewall running on the host system? It might be blocking
the VNC connection - in that case you could use port forwarding of ssh
(the -L parameter for example), or try to reconfigure your firewall on
the host.

 Thomas


PS: Don't forget to specify --enable-kvm in case you want to use
hardware virtualization.
