Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEFFC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CD12186A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CD12186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.con
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Uyb-0005N0-3r
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.con>) id 1i5Rqu-0004ry-1v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.con>) id 1i5Rqr-00007C-2S
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:45:23 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.con>)
 id 1i5Rql-0008N0-Gp; Wed, 04 Sep 2019 05:45:15 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 1D1CC96F5C;
 Wed,  4 Sep 2019 09:38:54 +0000 (UTC)
From: damien.hedde@greensocs.con
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 11:38:40 +0200
Message-Id: <20190904093843.8765-7-damien.hedde@greensocs.con>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904093843.8765-1-damien.hedde@greensocs.con>
References: <20190904093843.8765-1-damien.hedde@greensocs.con>
MIME-Version: 1.0
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
X-Mailman-Approved-At: Wed, 04 Sep 2019 08:47:47 -0400
Subject: [Qemu-devel] [PATCH v6 6/9] docs/clocks: add device's clock
 documentation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Add the documentation about the clock inputs and outputs in devices.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/clock.txt | 246 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 docs/devel/clock.txt

diff --git a/docs/devel/clock.txt b/docs/devel/clock.txt
new file mode 100644
index 0000000000..18f79922d0
--- /dev/null
+++ b/docs/devel/clock.txt
@@ -0,0 +1,246 @@
+
+What are clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Clocks are objects representing input and output clocks of objects. They=
 are
+QOM objects developed for the purpose of modeling the distribution of cl=
ocks in
+QEMU.
+
+This allows us to model the clock distribution of a platform and detect
+configuration errors in the clock tree such as badly configured PLL, clo=
ck
+source selection or disabled clock.
+
+The objects are ClockIn for the input and ClockOut for the output. The Q=
OM
+names are respectively CLOCK_IN and CLOCK_OUT.
+
+CLOCK_IN and CLOCK_OUT are typically child of some device and created in=
 a
+similar way as gpios. ClockIn and ClockOut of different devices can be
+connected together. It is possible to create a clock which is not relate=
d
+to a device; for example to model a clock source of a machine.
+
+Here is an example of devices with clocks:
+
+                             +-------------------+     +----------------=
----+
+                             |      Device B     |     |      Device C  =
    |
+  +--------------------+     |           +-----+ |     | +-----+        =
    |
+  |      Device A      |     |           |Clock|>>----->>|Clock|        =
    |
+  |            +-----+ |     | +-----+   |Out 3| |     | |In  5|        =
    |
+  |            |Clock|>>--+-->>|Clock|   +-----+ |     | +-----+        =
    |
+  |            |Out 1| |  |  | |In 2 |   +-----+ |     | +-----+        =
    |
+  |            +-----+ |  |  | +-----+   |Clock|>>----->>|Clock|        =
    |
+  +--------------------+  |  |           |Out 4| |     | |In  6|        =
    |
+                          |  |           +-----+ |     | +-----+        =
    |
+                          |  +-------------------+     +----------------=
----+
+                          |
+                          |  +--------------------+
+                          |  |      Device D      |
+                          |  | +-----+            |
+                          +-->>|Clock|            |
+                             | |In  7|            |
+                             | +-----+            |
+                             +--------------------+
+
+Clocks are defined in include/hw/clock.h header and device related funct=
ions
+are defined in hw/qdev-clock.h header.
+
+The clock state
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The state of a clock is its frequency; it is stored as an integer repres=
enting
+it in Hertz. The special value of 0 is used to represent the clock being
+inactive or gated. The clocks do not model the signal itself (pin toggli=
ng)
+or other properties such as the duty cycle.
+
+Only the CLOCK_IN object keeps the value of a clock; this allows a devic=
e to
+fetch the current input frequency at any time. When an output is updated=
, the
+value is immediately propagated to all connected CLOCK_IN.
+
+Adding clocks to a device
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Adding clocks to a device must be done during the init method of the Dev=
ice
+instance.
+
+To add an input clock to a device, the function qdev_init_clock_in must =
be used.
+It takes the name, a callback, and an opaque parameter for the clock.
+Output is more simple, only the name is required. Typically:
+qdev_init_clock_in(DEVICE(dev), "clk_in", clk_in_callback, dev);
+qdev_init_clock_out(DEVICE(dev), "clk_out");
+
+Both functions return the created ClockIn/ClockOut pointer, which should=
 be saved
+in the device's state structure for further use.
+
+These objects will be automatically deleted by the QOM reference mechani=
sm.
+
+Note that it is possible to create a static array describing clock input=
s and
+outputs. The function qdev_init_clocks() must be called with the array a=
s
+parameter to initialize the clocks: it has the same behaviour as calling=
 the
+qdev_init_clock_in/out() for each clock in the array. To ease the array
+construction, some macros are defined in include/hw/qdev-clock.h.
+As an example, the following creates 2 clocks to a device: 1 input and 1
+output.
+
+/* device structure containing pointer to the clock objects */
+typedef struct MyDeviceState {
+    DeviceState parent_obj;
+    ClockIn *clk_in;
+    ClockOut *clk_out;
+} MyDeviceState;
+
+/*
+ * callback for the input clock (see "Callback on input clock change" se=
ction
+ * below for more information).
+ */
+static void clk_in_callback(void *opaque);
+
+/*
+ * static array describing clocks:
+ * + a clock input named "clk_in", whose pointer is stored in clk_in
+ *   field of a MyDeviceState structure with callback clk_in_callback.
+ * + a clock output named "clk_out" whose pointer is stored in clk_out
+ *   field of a MyDeviceState structure.
+ */
+static const ClockPortInitArray mydev_clocks =3D {
+    QDEV_CLOCK_IN(MyDeviceState, clk_in, clk_in_callback),
+    QDEV_CLOCK_OUT(MyDeviceState, clk_out),
+    QDEV_CLOCK_END
+};
+
+/* device initialization function */
+static void mydev_init(Object *obj)
+{
+    /* cast to MyDeviceState */
+    MyDeviceState *mydev =3D MYDEVICE(obj);
+    /* create and fill the pointer fields in the MyDeviceState */
+    qdev_init_clocks(mydev, mydev_clocks);
+    [...]
+}
+
+Connecting two clocks together
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Let's say we have 2 devices A and B. A has an output clock named "clk_ou=
t" and
+B has an input clock named "clk_in".
+
+The clocks are connected together using the function qdev_connect_clock:
+qdev_connect_clock(B, "clk_in", A, "clk_out", &error_abort);
+The device which has the input must be the first argument.
+
+It is possible to connect several input clocks to the same output. Every
+input callback will be called when the output changes.
+
+It is not possible to disconnect a clock or to change the clock connecti=
on
+after it is done.
+
+Unconnected input clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A newly created input clock has a stored frequency value of 0. It means =
the
+clock will be considered as disabled until one sets a new frequency to t=
he
+output clock it is connected to. If the clock remains unconnected it wil=
l
+always keep its initial value of 0.
+If this is not the wanted behaviour, clock_init_frequency should be call=
ed
+on the ClockIn object during device instance init.
+For example:
+clk =3D qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback, dev);
+clock_init_frequency(clk, 100 * 1000 * 1000); // default value is 100Mhz
+
+Using clock input frequency
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+A device can get the current frequency of an input using the
+clock_get_frequency(). It returns the last set frequency (or the init va=
lue).
+
+It is also possible to register a callback on input clock frequency chan=
ges.
+Here is an example:
+void clock_callback(void *opaque) {
+    MyDeviceState *s =3D (MyDeviceState *) opaque;
+    /*
+     * opaque may not be the device state pointer, but most probably it =
is.
+     * (It depends on what is given to the qdev_init_clock_in function)
+     */
+
+    /* do something with the new frequency */
+    fprintf(stdout, "device new frequency is %" PRIu64 "Hz\n",
+                    clock_get_frequency(dev->my_clk_input));
+}
+
+Changing a clock output
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A device can change its outputs using the clock_set_frequency function. =
It
+will trigger updates on every connected inputs.
+
+For example, let's say that we have an output clock "clkout" and we have=
 a
+pointer to it in the device state because we did the following in init p=
hase:
+dev->clkout =3D qdev_init_clock_out(DEVICE(dev), "clkout");
+
+Then at any time (apart from the cases listed below), it is possible to
+change the clock value by doing:
+clock_set_frequency(dev->clkout, 1000 * 1000 * 1000); /* 1Ghz */
+This operation must be done while holding the qemu io lock.
+
+One can change clocks only when it is allowed to have side effects on ot=
her
+objects. In consequence, it is forbidden:
++ during migration,
++ and in the init phase of reset.
+
+Forwarding clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Sometimes, one needs to forward, or inherit, a clock from another device=
.
+Typically, when doing device composition, a device might expose a sub-de=
vice's
+clock without interfering with it.
+The function qdev_pass_clock() can be used to achieve this behaviour. No=
te, that
+it is possible to expose the clock under a different name. This works fo=
r both
+inputs or outputs.
+
+For example, if device B is a child of device A, device_a_instance_init =
may
+do something like this:
+void device_a_instance_init(Object *obj)
+{
+    AState *A =3D DEVICE_A(obj);
+    BState *B;
+    /* create B object as child of A */
+    [...]
+    /* forward B's clock to A */
+    qdev_pass_clock(A, "b_clk", B, "clk");
+    /*
+     * Now A has a clock "b_clk" which forwards to
+     * the "clk" of its child B.
+     */
+}
+
+This function does not return any clock object. It is not possible to ad=
d
+a callback on a forwarded input clock: in the above example, only B can =
use
+the clock.
+
+Migration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Only the ClockIn object has a state. ClockOut is not concerned by migrat=
ion.
+
+In case the frequency of in input clock is needed for a device's migrati=
on,
+this state must be migrated. The VMSTATE_CLOCKIN macro defines an entry =
to
+be added in a vmstate description.
+
+For example, if a device has a clock input and the device state looks li=
ke:
+MyDeviceState {
+    DeviceState parent_obj;
+    ClockIn *clk;
+};
+
+Then, to add the clock frequency to the device's migrated state, the vms=
tate
+description is:
+VMStateDescription my_device_vmstate =3D {
+    .name =3D "my_device",
+    .fields =3D (VMStateField[]) {
+        VMSTATE_CLOCKIN(clk, MyDeviceState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+When adding a input clock support to an existing device, you must care a=
bout
+migration compatibility. To this end, you can use the clock_init_frequen=
cy in
+a pre_load function to setup a default value in case the source vm does =
not
+migrate the frequency.
--=20
2.22.0


