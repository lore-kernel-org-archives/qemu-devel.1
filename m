Received: from eggs.gnu.org ([209.51.188.92]:60163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5yQ-0006qz-GJ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5yP-0007E4-3s
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH5yO-0007Ch-At
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so2673964wrw.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:16:59 -0700 (PDT)
References: <CAAxVKALOPZiBG3u6Co6vXuA5_WWJrOdDUsk=3n4gTOhkuV23rw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5b19003-6c63-df5d-ce44-2d681103d447@redhat.com>
Date: Thu, 18 Apr 2019 14:16:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAAxVKALOPZiBG3u6Co6vXuA5_WWJrOdDUsk=3n4gTOhkuV23rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Virtio based IEEE 802.11 device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ratnaraj Mirgal <ratnaraj.mirgal@gmail.com>, qemu-devel@nongnu.org

On 4/17/19 12:00 PM, Ratnaraj Mirgal wrote:
> Hi All,
> 
> At the outset, I do understand there is no mainstream requirement for
> having virtual wireless NIC, if et all there is any, mac80211_hwsim (part
> of Linux) is more than sufficient.
> 
> So this is purely an academic attempt.
> 
> In order to support following topology,
> 
> [image: qemu-wifi-topology.png]

I never thought of sending a picture of an ASCII schema =)

> I am implementing IEEE 802.11 softmac device based on virtio driver. I
> wanted to use existing netdev trasport like socket, however due to lack of
> better understanding of internals I have added new netdev (airport), which
> is very similar to VDE transport implementation. On frontend side, I have
> combined virtio-net and mac80211_hwsim to form frontend wireless driver.
> 
> As of now all driver are loading, and further working on correcting queue
> implementation.
> 
> 00:03.0 Network controller [0280]: Red Hat, Inc Device [1af4:100a]
> 	Subsystem: Red Hat, Inc Device [1af4:000a]
> 	Kernel driver in use: virtio-pci
> 
> # lsmod
> Module                  Size  Used by    Tainted: G
> arc4                   16384  2
> virtio_mac80211        24576  0
> mac80211              356352  1 virtio_mac80211
> sha256_generic         24576  0
> cfg80211              221184  1 mac80211
> 
> 4: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> default qlen 1000
>     link/ether 52:55:00:d1:55:01 brd ff:ff:ff:ff:ff:ff
> 
> 
> I have kept the repository at,
> https://github.com/ra7narajm/virtio-mac80211
> 
> So if possible, do go through and let me know any mistakes.
> 
> Thank You.
> 
> -
> Ratnaraj
> 
