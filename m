Received: from eggs.gnu.org ([2001:4830:134:3::10]:51176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1f3y5f-0006rI-Vr
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1f3y5e-00004r-TY
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:09:43 -0400
MIME-Version: 1.0
From: Prakash B <bjsprakash.linux@gmail.com>
Date: Thu, 5 Apr 2018 11:39:41 +0530
Message-ID: <CACJhumcLYPhMkO5idkL0eW6nsdbwhFv3KMWi9c5Q5bPv_2Rq6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Virito devices bridge vs Macvtap performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>, Sunil Goutham <sgoutham@cavium.com>, bprakash@caviumnetworks.com, berrange@redhat.com

Hi,

I am doing kvm guest network performance analysis to compare relevant
alternatives for  virtio devices on Arrach64.

I have generated bridge tap and macvtap performance numbers  on guest
10G interface
connected back to  another 10G on other host.

The results for guest with  "macvtap" vs  "bridge" are  marginally
differed and the difference is +/- 3%. As per my understanding on
macvtap, expected better performance values with macvtap.


--------------------<Begin of commands > --------------------
for  macvtap device:-
-netdev tap,vhost=on,vhostforce=on,id=macvtap_netdev,fd=3
3<>/dev/tap$(cat /sys/class/net/macvtap1/ifindex)  \
 -device virtionet-pci,netdev=macvtap_netdev,id=net0,mac=$(cat
/sys/class/net/macvtap1/address)

for Bridge tap device:-
-netdev type=tap,vhost=on,vhostforce=on,id=tap0,ifname=tap0,script=no,downscript=no
-device virtio-net-pci,netdev=tap0,mac=12:03:04:05:06:07

-----------------------< End of commands> ------------------------

Anyone please tell me if I missed anything.

Other information.
-------------------------
Kernel sources :  4.14.28
qemu-aarch64 :  2.11.91

Did the same  experiments with ThunderX vnic and Intel 10G nic and
results are as mentioned above.
Tried macvtap in bridge and passthru modes.


Tell me if  you  need further investigations or more data .

thanks,
Prakash B
