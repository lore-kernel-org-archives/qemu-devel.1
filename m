Received: from eggs.gnu.org ([2001:4830:134:3::10]:51328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey@xdel.ru>) id 1dGNmy-0004qU-WE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey@xdel.ru>) id 1dGNmy-0007AN-0o
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:57:13 -0400
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrey@xdel.ru>) id 1dGNmx-0007A2-Ju
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:57:11 -0400
Received: by mail-yw0-x232.google.com with SMTP id 63so5831556ywr.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 03:57:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEcfeEx1nB-jZwLO1kmt1Mv+3JoBtrWPVpCaAkSEpLXne6oL1Q@mail.gmail.com>
References: <CAEcfeEx1nB-jZwLO1kmt1Mv+3JoBtrWPVpCaAkSEpLXne6oL1Q@mail.gmail.com>
From: Andrey Korolyov <andrey@xdel.ru>
Date: Thu, 1 Jun 2017 13:56:48 +0300
Message-ID: <CABYiri8vcRmOiH6ogGjXULuZXMo1Dh2a2nagLhSfUnS_B9+1Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Tracking hugepages usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladyslav Drok <vdrok@mirantis.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jun 1, 2017 at 1:38 PM, Vladyslav Drok <vdrok@mirantis.com> wrote:
> Hello qemu community!
>
> I come from openstack world, and one of our customers complains about an
> issue with huge pages on compute nodes. From the "virsh frepages --all" and
> "cat /proc/meminfo", they see that 4 huge pages are consumed:
>
> http://paste.openstack.org/show/611186/
>
> In total there are 239 1G pages, 120 in numa node 0, and 119 in numa node
> 1. There are no VMs running at this point.
>
> When trying to find out what consumes the 4 1G huge pages from node 0, I
> was suggesting "grep 1048576 /proc/*/numa_maps" to find out which processes
> are using 1G pages, but in this particular case it shows no processes.
> While when some VM is running, I can see the qemu process that's consuming
> huge pages, numa_maps reports the correct amount of pages, corresponding to
> what has been requested for the VM's RAM.
>
> Are there any recommended ways for trying to track what consumes these 4
> "lost" pages? (I might be a bit slow providing more info, as I don't have
> access to this environment :( )
>
> Thanks,
> Vlad

Could you please try to walk against /proc/[0-9]/smaps to check that
these pages are not claimed by any process?
