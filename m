Received: from eggs.gnu.org ([209.51.188.92]:35867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyw-0008GK-EE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyt-0003r3-PO
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyt-0003V5-DS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:39 -0500
Date: Tue, 15 Jan 2019 15:06:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-45-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 44/49] acpi: update expected files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Update expected files affected by:
hw: acpi: Fix memory hotplug AML generation error

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/pc/DSDT.dimmpxm  | Bin 6790 -> 6784 bytes
 tests/data/acpi/pc/DSDT.memhp    | Bin 6496 -> 6490 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9474 -> 9468 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9180 -> 9174 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 8947 -> 8945 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index f6ec911b1180a409e61ef8d50279ab6dba7f1bdd..ad2800de672534dc87012f03e27b19671a330083 100644
GIT binary patch
delta 159
zcmZoOZ7}6>33dr-kYZq96xzsD#lz#{6QdU&>=f_o5#T&|qL9euB|H|)jJ}ia@_VZY
z#`_0{F#7_D_)t%mjLa+%{&-g}14dsU0TzjF@}2A_K%~O`0^Sn1Ox&y@n8XPH@s=#v

delta 151
zcmZoLZ8PO^33dr-lVV_CG~CEl#lz&}ySa@gjG57Y@?Cy!HKBO_;1K2|zCbcQ)YBy+
nGfPAu-qp*1afvUG1Pets`A_x{AX@2e0dFbXrf!xKOyUFp_>(Mp

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index e31ef502968b14e2146cb1a1328dc0ce555b1d7f..9e75ac96e15730f245ff6730bd28127ad827119a 100644
GIT binary patch
delta 159
zcmaE0bjyg#CD<h-N|J$raq&j33~nADpBTOPV5fLrj{xV%8w5o*PvW*<X7rtWn$KHB
zFy22ngxMEJ#D{viWMpQE@W;D)88G?+39v|Xlka33ej*jF<@c7rW#VQb0Y6Rvf}Aah

delta 151
zcmca*^uUPACD<h-L6U)i@z6%D3~nYT-_0f5Va$yFlTY(`s|m&X2Zt~(@dc9cp`I=o
nnOPzN@vdG5j7xlhBv>fA$$zpHKha88@_S3+Hgz+PfFCCSaaJu1

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 3837792dec13c4c77c66b140f68959d86a09de8e..7177116a21969fa3649053ec83a8704b0d84b9c5 100644
GIT binary patch
delta 145
zcmZqj`s2yv66_N4M}>ib@$g126FDXypUn<(Va$xalcy_ss|d#X2Zu2G0*UxgPnV3$
lED`>AS1$ubUmyV%iEi?p%%Mc2!b&A?30x*_zNe(Z1ON^VDcS%4

delta 151
zcmez4+2qCL66_Mfq{_g+_;4eai5!!Y?`8+NFlI*o$<r0R)r8{xgF~2?_yWoJP*0bP
n%q$Uscvmk2#wET$5-b$m<Ug5BiD;#zO5ReqP2GG$Nredj57R8v

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 8fba0baf79de0239f2630035afeee78f3e7f43c2..0235461391c90d577c3d533c2fd29ce50f1e2981 100644
GIT binary patch
delta 145
zcmccPe$AcBCD<k8nlb|eW6?$~C0QmPpUrx*Va$xalUo(MRRrVxgF~2ofkb?$r%Og=
kmI!~mtCs<zFOUF>L^t_P{zk0AbVY9oTqbTlqbR@x01+4}3IG5A

delta 151
zcmccSe#f25CD<k8jxqxS<HU_zO0rB&zMJ)A!<ZTUC$}nis|m&X2Zt~(@dc9cp`I=o
mnOPzN@vdG5j7xlhBv>fA$$#<};*};VdQ0Ipb@MSr0VV*TS}p_t

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index a058ff2ee31a22a55b5b198bc1531c7f20b243f6..f60ee77fb4d655e77c7ef1e8c205d741cc288939 100644
GIT binary patch
delta 62
zcmezD`q7okCD<k8qY?uHquxd?C0Rzd&APH-%#6O1TNJz{1mpdKLzsPmM0}{HOGajv
Q2!Fh*mjUDEmkL}=0723bn*aa+

delta 64
zcmez9`q`DsCD<k8vl0UX<GqbsO0tX|n{{Qwm>K;iw<vf^3B~&dhcGYk1(NZho-P@g
TSt0`Qu3iR=OEy1O;9>#*lp+(G

-- 
MST
