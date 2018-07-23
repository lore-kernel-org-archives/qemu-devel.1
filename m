Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fhOyj-0004Gi-I7
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 20:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fhOyY-00041U-HO
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 20:45:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1fhOyX-00040l-9P
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 20:45:22 -0400
Received: by mail-lj1-x241.google.com with SMTP id q127-v6so15389330ljq.11
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 17:45:21 -0700 (PDT)
Received: from [192.168.1.103] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	d6-v6sm1184612lfc.83.2018.07.22.17.45.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 22 Jul 2018 17:45:17 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 23 Jul 2018 03:42:05 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dRSVbI8xVK+29xZ"
Message-Id: <201807230342.05279.randrianasulu@gmail.com>
Subject: [Qemu-devel] qemu-system_x86-64 (32-bit binary) -M q35 can be
 crashed on viewing youtube.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--Boundary-00=_dRSVbI8xVK+29xZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It was crashing and crashing, so I tried to debug it a bit ... 


valgrind --leak-check=yes /dev/shm/qemu/x86_64-softmmu/qemu-system-x86_64  -display 
sdl,gl=on  -M q35 -soundhw 
hda -cdrom /home/guest/Downloads/ISO/slax-English-US-7.0.8-x86_64.iso -m 
1G -enable-kvm -d trace:e1000e*   shows some errors at very end, see attached 
file.

For reproduction, wait for liveCD to finish loading, start firefox, go to 
youtube.com, it will warn you about outdated browser but continue anyway, try 
to click on any video ....

It seems even modern KDE Neon distribution affected by same bug :/
--------------quote-----

29362@1532305439.464672:e1000e_core_write Write to register 0xd0, 4 byte(s), 
value: 0x100000
29362@1532305439.464735:e1000e_irq_set_ims Setting IMS bits 0x100000: 
0x1500004 --> 0x1500004
29362@1532305439.464791:e1000e_irq_msix_pending_clearing Clearing MSI-X pending 
bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.464867:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 
0x80000002
29362@1532305439.464916:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 
0x80000002, IMS: 0x1500004)
29362@1532305439.524010:e1000e_core_write Write to register 0x3818, 4 byte(s), 
value: 0x97
29362@1532305439.524097:e1000e_tx_descr 0x21180e : 27000b68 5b43600
29362@1532305439.524169:e1000e_tx_descr 0x3bf970fa : 261005c6 300
29362@1532305439.524248:e1000e_tx_descr 0x1c1c8000 : af1005d8 300
==29362== Invalid write of size 4
==29362==    at 0x552E58: memcpy (string3.h:53)
==29362==    by 0x552E58: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b60 is 0 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid write of size 4
==29362==    at 0x552E5E: memcpy (string3.h:53)
==29362==    by 0x552E5E: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b78 is 24 bytes before an unallocated block of size 
156,632 in arena "client"
==29362==
==29362== Invalid write of size 4
==29362==    at 0x552E6B: memcpy (string3.h:53)
==29362==    by 0x552E6B: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b64 is 4 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D710: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b60 is 0 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D716: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b62 is 2 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D71C: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b64 is 4 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D722: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b66 is 6 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D728: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b68 is 8 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D72E: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6a is 10 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D734: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6c is 12 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D73A: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6e is 14 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D780: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b72 is 18 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D784: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b70 is 16 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==

valgrind: m_mallocfree.c:303 (get_bszB_as_is): Assertion 'bszB_lo == bszB_hi' 
failed.
valgrind: Heap block lo/hi size mismatch: lo = 3024, hi = 4106420400.
This is probably caused by your program erroneously writing past the
end of a heap block and corrupting heap metadata.  If you fix any
invalid writes reported by Memcheck, this assertion failure will
probably go away.  Please try that before reporting this as a bug.


host stacktrace:
==29362==    at 0x3803B71E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803B846: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803B96D: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3804BE12: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803424E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x380321BF: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803262F: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803714E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803169D: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3800FCEB: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x8809D25D: ???

sched status:
  running_tid=5

Thread 1: status = VgTs_WaitSys (lwpid 29362)
==29362==    at 0x55413CE: ppoll (in /lib/libc-2.23.so)
==29362==    by 0x683634: ppoll (poll2.h:77)
==29362==    by 0x683634: qemu_poll_ns (qemu-timer.c:334)
==29362==    by 0x6847C9: os_host_main_loop_wait (main-loop.c:233)
==29362==    by 0x6847C9: main_loop_wait (main-loop.c:497)
==29362==    by 0x398A6D: main_loop (vl.c:1866)
==29362==    by 0x1FF9E9: main (vl.c:4644)

Thread 2: status = VgTs_WaitSys (lwpid 29363)
==29362==    at 0x5547C12: syscall (in /lib/libc-2.23.so)
==29362==    by 0x68854C: qemu_futex_wait (futex.h:29)
==29362==    by 0x68854C: qemu_event_wait (qemu-thread-posix.c:442)
==29362==    by 0x69A300: call_rcu_thread (rcu.c:261)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 3: status = VgTs_WaitSys (lwpid 29364)
==29362==    at 0x55413CE: ppoll (in /lib/libc-2.23.so)
==29362==    by 0x68365D: ppoll (poll2.h:77)
==29362==    by 0x68365D: qemu_poll_ns (qemu-timer.c:322)
==29362==    by 0x68569D: aio_poll (aio-posix.c:629)
==29362==    by 0x391D8C: iothread_run (iothread.c:64)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 4: status = VgTs_WaitSys (lwpid 29492)
==29362==    at 0x54593FD: __libc_do_syscall (in /lib/libpthread-2.23.so)
==29362==    by 0x5456148: do_futex_wait (in /lib/libpthread-2.23.so)
==29362==    by 0x5456258: __new_sem_wait_slow (in /lib/libpthread-2.23.so)
==29362==    by 0x6882B5: qemu_sem_timedwait (qemu-thread-posix.c:289)
==29362==    by 0x682B05: worker_thread (thread-pool.c:92)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 5: status = VgTs_Runnable (lwpid 29367)
==29362==    at 0x54D78C: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x47C1C1: net_tx_pkt_sendv (net_tx_pkt.c:546)
==29362==    by 0x47C1C1: net_tx_pkt_do_sw_fragmentation (net_tx_pkt.c:588)
==29362==    by 0x47CF0F: net_tx_pkt_send (net_tx_pkt.c:625)
==29362==    by 0x487256: e1000e_tx_pkt_send (e1000e_core.c:665)
==29362==    by 0x487256: e1000e_process_tx_desc (e1000e_core.c:742)
==29362==    by 0x487256: e1000e_start_xmit (e1000e_core.c:933)
==29362==    by 0x4875DF: e1000e_set_tdt (e1000e_core.c:2450)
==29362==    by 0x48A7F3: e1000e_core_write (e1000e_core.c:3255)
==29362==    by 0x47FCD1: e1000e_mmio_write (e1000e.c:105)
==29362==    by 0x271548: memory_region_write_accessor (memory.c:527)
==29362==    by 0x26D783: access_with_adjusted_size (memory.c:594)
==29362==    by 0x274308: memory_region_dispatch_write (memory.c:1486)
==29362==    by 0x209B6C: flatview_write_continue (exec.c:3255)
==29362==    by 0x209DA4: flatview_write (exec.c:3294)
==29362==    by 0x20E0A4: address_space_write (exec.c:3384)
==29362==    by 0x288278: kvm_cpu_exec (kvm-all.c:1979)
==29362==    by 0x25B256: qemu_kvm_cpu_thread_fn (cpus.c:1215)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 6: status = VgTs_WaitSys (lwpid 29373)
==29362==    at 0x5453AE1: pthread_cond_wait@@GLIBC_2.3.2 
(in /lib/libpthread-2.23.so)
==29362==    by 0xC3F5149: ??? (in /usr/X11R7/lib/dri/nouveau_dri.so)
==29362==    by 0xC3F4EB4: ??? (in /usr/X11R7/lib/dri/nouveau_dri.so)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)


Note: see also the FAQ in the source distribution.
It contains workarounds to several common problems.
In particular, if Valgrind aborted or crashed after
identifying problems in your program, there's a good chance
that fixing those problems will prevent Valgrind aborting or
crashing, especially if it happened in m_mallocfree.c.

If that doesn't help, please report this bug to: www.valgrind.org

In the bug report, send all the above text, the valgrind
version, and what OS and version you are using.  Thanks.

------------quote end-----

it seems slirp (user-mode networking) and e1000e doesn't work yet?


You can download slax-English-US-7.0.8-x86_64.iso for example from 
http://ftp.linux.cz/pub/linux/slax/Slax-7.x/7.0.8/

default machine (without M parameter) works fine, also -M pc-q35-2.11 works 
fine.

qemu-system-x86_64 --version
QEMU emulator version 2.12.91 (v3.0.0-rc1-17-g5b3ecd3d94-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

(same as in my qemu-system-ppc bug)

--Boundary-00=_dRSVbI8xVK+29xZ
Content-Type: text/plain;
  charset="iso 8859-1";
  name="log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log.txt"

29362@1532305438.893429:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305438.893464:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305438.893502:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305438.893558:e1000e_ring_free_space ring #0: LEN: 4096, DH: 37, DT: 32
29362@1532305438.893608:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305438.893647:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305438.893685:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305438.893728:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305438.893771:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305438.893810:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305438.893857:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305438.893913:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305438.893981:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305438.894026:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305438.894101:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305438.894146:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305438.894188:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305438.894227:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305438.894273:e1000e_irq_postponed_by_xitr Interrupt postponed by [E]ITR register 0xec
29362@1532305438.894311:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305438.894354:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305438.894504:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305438.894617:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305438.895306:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305438.895359:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305438.895420:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305438.895487:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305438.895535:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305438.909229:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x84
29362@1532305438.909313:e1000e_tx_descr (nil) : 21000000 0
29362@1532305438.909382:e1000e_tx_descr 0x286f5cfa : ab100036 200
29362@1532305438.909563:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305438.909606:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305438.909654:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305438.909695:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305438.909745:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305438.909819:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305438.909899:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305438.909947:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305438.910205:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.298931:e1000e_core_read Read from register 0x4000, 4 byte(s), value: 0x0
29362@1532305439.299540:e1000e_core_read Read from register 0x4074, 4 byte(s), value: 0x625
29362@1532305439.299707:e1000e_core_read Read from register 0x4088, 4 byte(s), value: 0x1c469a
29362@1532305439.299868:e1000e_core_read Read from register 0x408c, 4 byte(s), value: 0x0
29362@1532305439.300039:e1000e_core_read Read from register 0x4078, 4 byte(s), value: 0x0
29362@1532305439.300617:e1000e_core_read Read from register 0x407c, 4 byte(s), value: 0x0
29362@1532305439.300783:e1000e_core_read Read from register 0x40ac, 4 byte(s), value: 0x0
29362@1532305439.300951:e1000e_core_read Read from register 0x4010, 4 byte(s), value: 0x0
29362@1532305439.301504:e1000e_core_read Read from register 0x4048, 4 byte(s), value: 0x0
29362@1532305439.301669:e1000e_core_read Read from register 0x404c, 4 byte(s), value: 0x0
29362@1532305439.301830:e1000e_core_read Read from register 0x4050, 4 byte(s), value: 0x0
29362@1532305439.301990:e1000e_core_read Read from register 0x4054, 4 byte(s), value: 0x0
29362@1532305439.302540:e1000e_core_read Read from register 0x4080, 4 byte(s), value: 0x12
29362@1532305439.302705:e1000e_core_read Read from register 0x4090, 4 byte(s), value: 0x1f3fc
29362@1532305439.302864:e1000e_core_read Read from register 0x4094, 4 byte(s), value: 0x0
29362@1532305439.303027:e1000e_core_read Read from register 0x40a0, 4 byte(s), value: 0x0
29362@1532305439.303571:e1000e_core_read Read from register 0x40a4, 4 byte(s), value: 0x8
29362@1532305439.303734:e1000e_core_read Read from register 0x40f0, 4 byte(s), value: 0x0
29362@1532305439.303893:e1000e_core_read Read from register 0x40f4, 4 byte(s), value: 0x0
29362@1532305439.304057:e1000e_core_read Read from register 0x40d4, 4 byte(s), value: 0x12
29362@1532305439.304539:e1000e_core_read Read from register 0x4004, 4 byte(s), value: 0x0
29362@1532305439.304630:e1000e_core_read Read from register 0x400c, 4 byte(s), value: 0x0
29362@1532305439.304717:e1000e_core_read Read from register 0x403c, 4 byte(s), value: 0x0
29362@1532305439.304804:e1000e_core_read Read from register 0x40f8, 4 byte(s), value: 0x0
29362@1532305439.304890:e1000e_core_read Read from register 0x40fc, 4 byte(s), value: 0x0
29362@1532305439.304975:e1000e_core_read Read from register 0x40bc, 4 byte(s), value: 0x0
29362@1532305439.305282:e1000e_core_read Read from register 0x40b4, 4 byte(s), value: 0x0
29362@1532305439.305396:e1000e_core_read Read from register 0x40b8, 4 byte(s), value: 0x0
29362@1532305439.305545:e1000e_core_write Write to register 0xc8, 4 byte(s), value: 0x100000
29362@1532305439.305610:e1000e_irq_write_ics Adding ICR bits 0x100000
29362@1532305439.305655:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.305707:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.305762:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.305812:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.305868:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.305951:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.306082:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.306128:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.306351:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.306966:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.307022:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.307085:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.307146:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.307197:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.307522:e1000e_core_write Write to register 0x3820, 4 byte(s), value: 0x80000008
29362@1532305439.307574:e1000e_irq_tidv_fpd_not_running FPD written while TIDV was not running
29362@1532305439.307662:e1000e_core_write Write to register 0x2820, 4 byte(s), value: 0x80000020
29362@1532305439.307721:e1000e_irq_rdtr_fpd_not_running FPD written while RDTR was not running
29362@1532305439.307808:e1000e_link_status Link up: 1, Duplex: 1, Speed: 2, ASDV: 2
29362@1532305439.307865:e1000e_core_read Read from register 0x8, 4 byte(s), value: 0x283
29362@1532305439.307975:e1000e_core_write Write to register 0x3820, 4 byte(s), value: 0x80000008
29362@1532305439.308036:e1000e_irq_tidv_fpd_not_running FPD written while TIDV was not running
29362@1532305439.308348:e1000e_core_write Write to register 0x2820, 4 byte(s), value: 0x80000020
29362@1532305439.308413:e1000e_irq_rdtr_fpd_not_running FPD written while RDTR was not running
29362@1532305439.308507:e1000e_link_status Link up: 1, Duplex: 1, Speed: 2, ASDV: 2
29362@1532305439.308566:e1000e_core_read Read from register 0x8, 4 byte(s), value: 0x283
29362@1532305439.317223:e1000e_core_read Read from register 0xf00, 4 byte(s), value: 0x8
29362@1532305439.317324:e1000e_core_write Write to register 0xf00, 4 byte(s), value: 0x28
29362@1532305439.317424:e1000e_core_read Read from register 0xf00, 4 byte(s), value: 0x28
29362@1532305439.317515:e1000e_core_write Write to register 0x20, 4 byte(s), value: 0x4360000
29362@1532305439.317568:e1000e_core_mdic_write MDIC WRITE: PHY[0][22] = 0x0
29362@1532305439.317709:e1000e_core_read Read from register 0x20, 4 byte(s), value: 0x14360000
29362@1532305439.317801:e1000e_core_write Write to register 0x20, 4 byte(s), value: 0x8350000
29362@1532305439.317851:e1000e_core_mdic_read MDIC READ: PHY[0][21] = 0x8350000
29362@1532305439.317989:e1000e_core_read Read from register 0x20, 4 byte(s), value: 0x18350000
29362@1532305439.318267:e1000e_core_read Read from register 0xf00, 4 byte(s), value: 0x28
29362@1532305439.318351:e1000e_core_write Write to register 0xf00, 4 byte(s), value: 0x8
29362@1532305439.383514:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x86
29362@1532305439.383604:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.383664:e1000e_tx_descr 0x3bf970fa : ab1001b8 200
29362@1532305439.383867:e1000e_ring_free_space ring #0: LEN: 4096, DH: 37, DT: 32
29362@1532305439.383913:e1000e_rx_has_buffers ring #0: free descr: 251, packet size 1, descr buffer size 2048
29362@1532305439.383958:e1000e_rx_can_recv Can receive
29362@1532305439.383992:e1000e_ring_free_space ring #0: LEN: 4096, DH: 37, DT: 32
29362@1532305439.384036:e1000e_rx_has_buffers ring #0: free descr: 251, packet size 1, descr buffer size 2048
29362@1532305439.384076:e1000e_rx_can_recv Can receive
29362@1532305439.384106:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.384162:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.384191:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.384219:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.384251:e1000e_ring_free_space ring #0: LEN: 4096, DH: 37, DT: 32
29362@1532305439.384291:e1000e_rx_has_buffers ring #0: free descr: 251, packet size 60, descr buffer size 2048
29362@1532305439.384345:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a250, length: 16
29362@1532305439.384394:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fc3c0, offset: 0, from: 0x8697c00, length: 60
29362@1532305439.384456:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.384499:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.384528:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.384560:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.384611:e1000e_ring_free_space ring #0: LEN: 4096, DH: 38, DT: 32
29362@1532305439.384652:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.384685:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.384717:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.384754:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.384790:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.384821:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.384861:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.384926:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.385017:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.385055:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.385127:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.385164:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.385200:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.385232:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.385271:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.385317:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.385368:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.385405:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.385554:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.385650:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.386211:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.386258:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.386298:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.386340:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.386372:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.388002:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x88
29362@1532305439.388062:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.388116:e1000e_tx_descr 0x3bf970fa : ab100520 200
29362@1532305439.388289:e1000e_ring_free_space ring #0: LEN: 4096, DH: 38, DT: 32
29362@1532305439.388334:e1000e_rx_has_buffers ring #0: free descr: 250, packet size 1, descr buffer size 2048
29362@1532305439.388378:e1000e_rx_can_recv Can receive
29362@1532305439.388428:e1000e_ring_free_space ring #0: LEN: 4096, DH: 38, DT: 32
29362@1532305439.388469:e1000e_rx_has_buffers ring #0: free descr: 250, packet size 1, descr buffer size 2048
29362@1532305439.388510:e1000e_rx_can_recv Can receive
29362@1532305439.388540:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.388589:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.388618:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.388645:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.388677:e1000e_ring_free_space ring #0: LEN: 4096, DH: 38, DT: 32
29362@1532305439.388726:e1000e_rx_has_buffers ring #0: free descr: 250, packet size 60, descr buffer size 2048
29362@1532305439.388784:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a260, length: 16
29362@1532305439.388837:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fcb40, offset: 0, from: 0x8697c00, length: 60
29362@1532305439.388914:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.388966:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.388997:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.389032:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.389083:e1000e_ring_free_space ring #0: LEN: 4096, DH: 39, DT: 32
29362@1532305439.389137:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.389182:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.389214:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.389250:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.389285:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.389317:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.389355:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.389413:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.389495:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.389533:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.389600:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.389637:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.389673:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.389709:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.389756:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.389806:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.389864:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.389905:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.390869:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.390969:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.391587:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.391635:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.391682:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.391734:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.391773:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.401147:e1000e_ring_free_space ring #0: LEN: 4096, DH: 39, DT: 32
29362@1532305439.401220:e1000e_rx_has_buffers ring #0: free descr: 249, packet size 1, descr buffer size 2048
29362@1532305439.401261:e1000e_rx_can_recv Can receive
29362@1532305439.401302:e1000e_ring_free_space ring #0: LEN: 4096, DH: 39, DT: 32
29362@1532305439.401349:e1000e_rx_has_buffers ring #0: free descr: 249, packet size 1, descr buffer size 2048
29362@1532305439.401401:e1000e_rx_can_recv Can receive
29362@1532305439.401436:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.401503:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.401539:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.401578:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.401623:e1000e_ring_free_space ring #0: LEN: 4096, DH: 39, DT: 32
29362@1532305439.401674:e1000e_rx_has_buffers ring #0: free descr: 249, packet size 205, descr buffer size 2048
29362@1532305439.401743:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a270, length: 16
29362@1532305439.401799:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fd2c0, offset: 0, from: 0xfef3d98c, length: 205
29362@1532305439.401884:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.401939:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.401979:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.402020:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.402084:e1000e_ring_free_space ring #0: LEN: 4096, DH: 40, DT: 32
29362@1532305439.402138:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.402185:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.402230:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.402280:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.402329:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.402374:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.402427:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.402492:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.402576:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.402619:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.402716:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.403277:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x8a
29362@1532305439.403341:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.403416:e1000e_tx_descr 0x286f54fa : ab100036 200
29362@1532305439.403568:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.403610:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.403661:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.403705:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.403757:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.403832:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.403898:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.403989:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.404133:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.404565:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.404621:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.404668:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.404719:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.404753:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.407209:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x8c
29362@1532305439.407274:e1000e_tx_descr (nil) : 20000000 0
29362@1532305439.407333:e1000e_tx_descr 0x3bee0802 : ab10005a 200
29362@1532305439.407516:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.407561:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.407604:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.407639:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.407683:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.407746:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.407830:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.407870:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.408010:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.408625:e1000e_ring_free_space ring #0: LEN: 4096, DH: 40, DT: 32
29362@1532305439.408690:e1000e_rx_has_buffers ring #0: free descr: 248, packet size 1, descr buffer size 2048
29362@1532305439.408747:e1000e_rx_can_recv Can receive
29362@1532305439.408791:e1000e_ring_free_space ring #0: LEN: 4096, DH: 40, DT: 32
29362@1532305439.408844:e1000e_rx_has_buffers ring #0: free descr: 248, packet size 1, descr buffer size 2048
29362@1532305439.408893:e1000e_rx_can_recv Can receive
29362@1532305439.408932:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.408998:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.409034:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.409075:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.409120:e1000e_ring_free_space ring #0: LEN: 4096, DH: 40, DT: 32
29362@1532305439.409169:e1000e_rx_has_buffers ring #0: free descr: 248, packet size 176, descr buffer size 2048
29362@1532305439.409233:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a280, length: 16
29362@1532305439.409283:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fda40, offset: 0, from: 0xfef3d74c, length: 176
29362@1532305439.409357:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 1, tcp: 0
29362@1532305439.409408:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.409447:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.409505:e1000e_ring_free_space ring #0: LEN: 4096, DH: 41, DT: 32
29362@1532305439.409556:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.409596:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.409634:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.409678:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.409720:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.409759:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.409805:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.409862:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.409929:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.409974:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.410050:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.410658:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.410714:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.410761:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.410811:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.410849:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.411244:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x8e
29362@1532305439.411310:e1000e_tx_descr (nil) : 20000000 0
29362@1532305439.411374:e1000e_tx_descr 0x3bee0802 : ab10005a 200
29362@1532305439.411555:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.411605:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.411650:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.411688:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.411745:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.411827:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.411911:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.411969:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.412634:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.417771:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x90
29362@1532305439.417862:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.417934:e1000e_tx_descr 0x3bf970fa : ab100071 200
29362@1532305439.418124:e1000e_ring_free_space ring #0: LEN: 4096, DH: 41, DT: 32
29362@1532305439.418187:e1000e_rx_has_buffers ring #0: free descr: 247, packet size 1, descr buffer size 2048
29362@1532305439.418244:e1000e_rx_can_recv Can receive
29362@1532305439.418285:e1000e_ring_free_space ring #0: LEN: 4096, DH: 41, DT: 32
29362@1532305439.418330:e1000e_rx_has_buffers ring #0: free descr: 247, packet size 1, descr buffer size 2048
29362@1532305439.418378:e1000e_rx_can_recv Can receive
29362@1532305439.418411:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.418471:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.418503:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.418535:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.418571:e1000e_ring_free_space ring #0: LEN: 4096, DH: 41, DT: 32
29362@1532305439.418616:e1000e_rx_has_buffers ring #0: free descr: 247, packet size 60, descr buffer size 2048
29362@1532305439.418675:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a290, length: 16
29362@1532305439.418723:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fe1c0, offset: 0, from: 0x8697c00, length: 60
29362@1532305439.418792:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.418842:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.418873:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.418909:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.418962:e1000e_ring_free_space ring #0: LEN: 4096, DH: 42, DT: 32
29362@1532305439.419015:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.419053:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.419089:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.419131:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.419176:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.419221:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.419276:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.419349:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.419444:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.419487:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.419564:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.419601:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.419637:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.419668:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.419707:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.419753:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.419805:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.419841:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.419976:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.420070:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.420469:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.420534:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.420575:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.420616:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.420648:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.427202:e1000e_ring_free_space ring #0: LEN: 4096, DH: 42, DT: 32
29362@1532305439.427261:e1000e_rx_has_buffers ring #0: free descr: 246, packet size 1, descr buffer size 2048
29362@1532305439.427308:e1000e_rx_can_recv Can receive
29362@1532305439.427346:e1000e_ring_free_space ring #0: LEN: 4096, DH: 42, DT: 32
29362@1532305439.427392:e1000e_rx_has_buffers ring #0: free descr: 246, packet size 1, descr buffer size 2048
29362@1532305439.427437:e1000e_rx_can_recv Can receive
29362@1532305439.427468:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.427524:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.427556:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.427586:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.427622:e1000e_ring_free_space ring #0: LEN: 4096, DH: 42, DT: 32
29362@1532305439.427665:e1000e_rx_has_buffers ring #0: free descr: 246, packet size 438, descr buffer size 2048
29362@1532305439.427724:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a2a0, length: 16
29362@1532305439.427769:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5fe940, offset: 0, from: 0xfef3d74c, length: 438
29362@1532305439.427838:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 1, tcp: 0
29362@1532305439.427884:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.427918:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.427973:e1000e_ring_free_space ring #0: LEN: 4096, DH: 43, DT: 32
29362@1532305439.428019:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.428054:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.428089:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.428128:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.428167:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.428200:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.428242:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.428294:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.428364:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.428445:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.428545:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.429802:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.429907:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.430068:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.430182:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.430272:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.448281:e1000e_ring_free_space ring #0: LEN: 4096, DH: 43, DT: 32
29362@1532305439.448560:e1000e_rx_has_buffers ring #0: free descr: 245, packet size 1, descr buffer size 2048
29362@1532305439.448612:e1000e_rx_can_recv Can receive
29362@1532305439.448656:e1000e_ring_free_space ring #0: LEN: 4096, DH: 43, DT: 32
29362@1532305439.448708:e1000e_rx_has_buffers ring #0: free descr: 245, packet size 1, descr buffer size 2048
29362@1532305439.448765:e1000e_rx_can_recv Can receive
29362@1532305439.448799:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.448861:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.448896:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.448934:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.448974:e1000e_ring_free_space ring #0: LEN: 4096, DH: 43, DT: 32
29362@1532305439.449029:e1000e_rx_has_buffers ring #0: free descr: 245, packet size 1467, descr buffer size 2048
29362@1532305439.449098:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a2b0, length: 16
29362@1532305439.449155:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5ff0c0, offset: 0, from: 0xfef3d98c, length: 1467
29362@1532305439.449240:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.449294:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.449334:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.449375:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.449446:e1000e_ring_free_space ring #0: LEN: 4096, DH: 44, DT: 32
29362@1532305439.449501:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.449542:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.449584:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.449634:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.449689:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.449729:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.449775:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.449834:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.449916:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.449966:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.450053:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.450407:e1000e_ring_free_space ring #0: LEN: 4096, DH: 44, DT: 32
29362@1532305439.450516:e1000e_rx_has_buffers ring #0: free descr: 244, packet size 1, descr buffer size 2048
29362@1532305439.450567:e1000e_rx_can_recv Can receive
29362@1532305439.450605:e1000e_ring_free_space ring #0: LEN: 4096, DH: 44, DT: 32
29362@1532305439.450648:e1000e_rx_has_buffers ring #0: free descr: 244, packet size 1, descr buffer size 2048
29362@1532305439.450691:e1000e_rx_can_recv Can receive
29362@1532305439.450722:e1000e_rx_receive_iov Received vector of 1 fragments
29362@1532305439.450769:e1000e_rx_rss_started Starting RSS processing
29362@1532305439.450799:e1000e_rx_rss_disabled RSS is disabled
29362@1532305439.450828:e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
29362@1532305439.450861:e1000e_ring_free_space ring #0: LEN: 4096, DH: 44, DT: 32
29362@1532305439.450902:e1000e_rx_has_buffers ring #0: free descr: 244, packet size 704, descr buffer size 2048
29362@1532305439.450957:e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x3b20a2c0, length: 16
29362@1532305439.451001:e1000e_rx_desc_buff_write buffer #0, addr: 0x3a5ff840, offset: 0, from: 0xfef3d98c, length: 704
29362@1532305439.451067:e1000e_rx_metadata_protocols protocols: ip4: 1, ip6: 0, udp: 0, tcp: 1
29362@1532305439.451112:e1000e_rx_metadata_ack the packet is TCP ACK
29362@1532305439.451141:e1000e_rx_metadata_pkt_type the packet type is 2
29362@1532305439.451174:e1000e_rx_metadata_no_virthdr the packet has no virt-header
29362@1532305439.451226:e1000e_ring_free_space ring #0: LEN: 4096, DH: 45, DT: 32
29362@1532305439.451270:e1000e_rx_written_to_guest Received packet written to guest (ICR causes 1048576)
29362@1532305439.451303:e1000e_rx_interrupt_set Receive interrupt set (ICR causes 1048576)
29362@1532305439.451336:e1000e_irq_set_cause_entry Going to set IRQ cause 0x100000, ICR: 0x80000002
29362@1532305439.451373:e1000e_irq_set_cause_exit Set IRQ cause 0x100000, ICR: 0x80100002
29362@1532305439.451410:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80100002
29362@1532305439.451444:e1000e_irq_pending_interrupts ICR PENDING: 0x100000 (ICR: 0x80100002, IMS: 0x1500004)
29362@1532305439.451485:e1000e_irq_rearm_timer Mitigation timer armed for register 0xE8, delay 128000 ns
29362@1532305439.451541:e1000e_irq_msix_notify_vec MSI-X notify vector 0x0
29362@1532305439.451599:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x100000
29362@1532305439.451638:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80100002, EIAC: 0x500000
29362@1532305439.451703:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[0]
29362@1532305439.452741:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x92
29362@1532305439.452804:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.452873:e1000e_tx_descr 0x286f54fa : ab100036 200
29362@1532305439.453029:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.453072:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.453122:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.453168:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.453220:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.453293:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.453389:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.453428:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.461440:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.462335:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x94
29362@1532305439.462417:e1000e_tx_descr (nil) : 21000000 0
29362@1532305439.462486:e1000e_tx_descr 0x286f5cfa : ab100036 200
29362@1532305439.462638:e1000e_irq_set_cause_entry Going to set IRQ cause 0x400002, ICR: 0x80000002
29362@1532305439.462687:e1000e_irq_set_cause_exit Set IRQ cause 0x400002, ICR: 0x80400002
29362@1532305439.462731:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80400002
29362@1532305439.462771:e1000e_irq_pending_interrupts ICR PENDING: 0x400000 (ICR: 0x80400002, IMS: 0x1500004)
29362@1532305439.462819:e1000e_irq_rearm_timer Mitigation timer armed for register 0xEC, delay 128000 ns
29362@1532305439.462892:e1000e_irq_msix_notify_vec MSI-X notify vector 0x1
29362@1532305439.462980:e1000e_irq_iam_clear_eiame Clearing IMS due to EIAME, IAM: 0xFE0FFFFF, cause: 0x400000
29362@1532305439.463027:e1000e_irq_icr_clear_eiac Clearing ICR bits due to EIAC, ICR: 0x80400002, EIAC: 0x500000
29362@1532305439.463563:e1000e_irq_msix_notify_postponed_vec Sending MSI-X postponed by EITR[1]
29362@1532305439.464672:e1000e_core_write Write to register 0xd0, 4 byte(s), value: 0x100000
29362@1532305439.464735:e1000e_irq_set_ims Setting IMS bits 0x100000: 0x1500004 --> 0x1500004
29362@1532305439.464791:e1000e_irq_msix_pending_clearing Clearing MSI-X pending bit for cause 0x100000, IVAR config 0x800a0908, vector 0
29362@1532305439.464867:e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000002
29362@1532305439.464916:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000002, IMS: 0x1500004)
29362@1532305439.524010:e1000e_core_write Write to register 0x3818, 4 byte(s), value: 0x97
29362@1532305439.524097:e1000e_tx_descr 0x21180e : 27000b68 5b43600
29362@1532305439.524169:e1000e_tx_descr 0x3bf970fa : 261005c6 300
29362@1532305439.524248:e1000e_tx_descr 0x1c1c8000 : af1005d8 300
==29362== Invalid write of size 4
==29362==    at 0x552E58: memcpy (string3.h:53)
==29362==    by 0x552E58: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b60 is 0 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid write of size 4
==29362==    at 0x552E5E: memcpy (string3.h:53)
==29362==    by 0x552E5E: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b78 is 24 bytes before an unallocated block of size 156,632 in arena "client"
==29362==
==29362== Invalid write of size 4
==29362==    at 0x552E6B: memcpy (string3.h:53)
==29362==    by 0x552E6B: m_cat (mbuf.c:143)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==  Address 0x114f9b64 is 4 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D710: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b60 is 0 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D716: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b62 is 2 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D71C: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b64 is 4 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D722: cksum (cksum.c:94)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b66 is 6 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D728: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b68 is 8 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D72E: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6a is 10 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D734: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6c is 12 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D73A: cksum (cksum.c:95)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b6e is 14 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D780: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b72 is 18 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==
==29362== Invalid read of size 2
==29362==    at 0x54D784: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==  Address 0x114f9b70 is 16 bytes after a block of size 2,976 alloc'd
==29362==    at 0x482B29C: malloc (vg_replace_malloc.c:299)
==29362==    by 0x534D3E1: g_malloc (in /usr/lib/libglib-2.0.so.0.4600.2)
==29362==    by 0x552B53: m_inc.part.1 (mbuf.c:166)
==29362==    by 0x552EAE: m_inc (string3.h:53)
==29362==    by 0x552EAE: m_cat (mbuf.c:141)
==29362==    by 0x54FE1E: ip_reass (ip_input.c:341)
==29362==    by 0x54FE1E: ip_input (ip_input.c:190)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==

valgrind: m_mallocfree.c:303 (get_bszB_as_is): Assertion 'bszB_lo == bszB_hi' failed.
valgrind: Heap block lo/hi size mismatch: lo = 3024, hi = 4106420400.
This is probably caused by your program erroneously writing past the
end of a heap block and corrupting heap metadata.  If you fix any
invalid writes reported by Memcheck, this assertion failure will
probably go away.  Please try that before reporting this as a bug.


host stacktrace:
==29362==    at 0x3803B71E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803B846: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803B96D: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3804BE12: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803424E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x380321BF: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803262F: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803714E: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3803169D: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x3800FCEB: ??? (in /usr/lib/valgrind/memcheck-x86-linux)
==29362==    by 0x8809D25D: ???

sched status:
  running_tid=5

Thread 1: status = VgTs_WaitSys (lwpid 29362)
==29362==    at 0x55413CE: ppoll (in /lib/libc-2.23.so)
==29362==    by 0x683634: ppoll (poll2.h:77)
==29362==    by 0x683634: qemu_poll_ns (qemu-timer.c:334)
==29362==    by 0x6847C9: os_host_main_loop_wait (main-loop.c:233)
==29362==    by 0x6847C9: main_loop_wait (main-loop.c:497)
==29362==    by 0x398A6D: main_loop (vl.c:1866)
==29362==    by 0x1FF9E9: main (vl.c:4644)

Thread 2: status = VgTs_WaitSys (lwpid 29363)
==29362==    at 0x5547C12: syscall (in /lib/libc-2.23.so)
==29362==    by 0x68854C: qemu_futex_wait (futex.h:29)
==29362==    by 0x68854C: qemu_event_wait (qemu-thread-posix.c:442)
==29362==    by 0x69A300: call_rcu_thread (rcu.c:261)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 3: status = VgTs_WaitSys (lwpid 29364)
==29362==    at 0x55413CE: ppoll (in /lib/libc-2.23.so)
==29362==    by 0x68365D: ppoll (poll2.h:77)
==29362==    by 0x68365D: qemu_poll_ns (qemu-timer.c:322)
==29362==    by 0x68569D: aio_poll (aio-posix.c:629)
==29362==    by 0x391D8C: iothread_run (iothread.c:64)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 4: status = VgTs_WaitSys (lwpid 29492)
==29362==    at 0x54593FD: __libc_do_syscall (in /lib/libpthread-2.23.so)
==29362==    by 0x5456148: do_futex_wait (in /lib/libpthread-2.23.so)
==29362==    by 0x5456258: __new_sem_wait_slow (in /lib/libpthread-2.23.so)
==29362==    by 0x6882B5: qemu_sem_timedwait (qemu-thread-posix.c:289)
==29362==    by 0x682B05: worker_thread (thread-pool.c:92)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 5: status = VgTs_Runnable (lwpid 29367)
==29362==    at 0x54D78C: cksum (cksum.c:100)
==29362==    by 0x555C93: tcp_input (tcp_input.c:336)
==29362==    by 0x54FEEB: ip_input (ip_input.c:206)
==29362==    by 0x552478: slirp_input (slirp.c:874)
==29362==    by 0x53FBE7: net_slirp_receive (slirp.c:121)
==29362==    by 0x537478: nc_sendv_compat (net.c:701)
==29362==    by 0x537478: qemu_deliver_packet_iov (net.c:728)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x53AB71: net_hub_receive_iov (hub.c:73)
==29362==    by 0x53AB71: net_hub_port_receive_iov (hub.c:124)
==29362==    by 0x53748D: qemu_deliver_packet_iov (net.c:726)
==29362==    by 0x53A649: qemu_net_queue_deliver_iov (queue.c:179)
==29362==    by 0x53A649: qemu_net_queue_send_iov (queue.c:224)
==29362==    by 0x538901: qemu_sendv_packet_async (net.c:764)
==29362==    by 0x538925: qemu_sendv_packet (net.c:772)
==29362==    by 0x47C1C1: net_tx_pkt_sendv (net_tx_pkt.c:546)
==29362==    by 0x47C1C1: net_tx_pkt_do_sw_fragmentation (net_tx_pkt.c:588)
==29362==    by 0x47CF0F: net_tx_pkt_send (net_tx_pkt.c:625)
==29362==    by 0x487256: e1000e_tx_pkt_send (e1000e_core.c:665)
==29362==    by 0x487256: e1000e_process_tx_desc (e1000e_core.c:742)
==29362==    by 0x487256: e1000e_start_xmit (e1000e_core.c:933)
==29362==    by 0x4875DF: e1000e_set_tdt (e1000e_core.c:2450)
==29362==    by 0x48A7F3: e1000e_core_write (e1000e_core.c:3255)
==29362==    by 0x47FCD1: e1000e_mmio_write (e1000e.c:105)
==29362==    by 0x271548: memory_region_write_accessor (memory.c:527)
==29362==    by 0x26D783: access_with_adjusted_size (memory.c:594)
==29362==    by 0x274308: memory_region_dispatch_write (memory.c:1486)
==29362==    by 0x209B6C: flatview_write_continue (exec.c:3255)
==29362==    by 0x209DA4: flatview_write (exec.c:3294)
==29362==    by 0x20E0A4: address_space_write (exec.c:3384)
==29362==    by 0x288278: kvm_cpu_exec (kvm-all.c:1979)
==29362==    by 0x25B256: qemu_kvm_cpu_thread_fn (cpus.c:1215)
==29362==    by 0x68792D: qemu_thread_start (qemu-thread-posix.c:504)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)

Thread 6: status = VgTs_WaitSys (lwpid 29373)
==29362==    at 0x5453AE1: pthread_cond_wait@@GLIBC_2.3.2 (in /lib/libpthread-2.23.so)
==29362==    by 0xC3F5149: ??? (in /usr/X11R7/lib/dri/nouveau_dri.so)
==29362==    by 0xC3F4EB4: ??? (in /usr/X11R7/lib/dri/nouveau_dri.so)
==29362==    by 0x544F308: start_thread (in /lib/libpthread-2.23.so)
==29362==    by 0x554CA5D: clone (in /lib/libc-2.23.so)


Note: see also the FAQ in the source distribution.
It contains workarounds to several common problems.
In particular, if Valgrind aborted or crashed after
identifying problems in your program, there's a good chance
that fixing those problems will prevent Valgrind aborting or
crashing, especially if it happened in m_mallocfree.c.

If that doesn't help, please report this bug to: www.valgrind.org

In the bug report, send all the above text, the valgrind
version, and what OS and version you are using.  Thanks.


--Boundary-00=_dRSVbI8xVK+29xZ--
