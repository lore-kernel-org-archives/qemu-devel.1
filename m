Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F231C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8F820644
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6wZb3lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKMJ-0006WH-DI
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+71a21e484f4bc027aef9+6249+infradead.org+dwmw2@merlin.srs.infradead.org>)
 id 1kOKIR-0002az-FX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:23 -0400
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:40260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+71a21e484f4bc027aef9+6249+infradead.org+dwmw2@merlin.srs.infradead.org>)
 id 1kOKIN-0006cl-DW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=uChHDOMe5/+z9rYHNt7c+ckvccD1B7zUe8ePbuImat4=; b=Z6wZb3lxXf22r7FTZICOIKHmGu
 HcUbyTVN8XzIS8UuXfmH30wrzda5iTYhc4g/zePm5lUMofSHYYgJLwqHrw5jLsBhucuT09YRds3qB
 ImvBEl4ibPyIz3HRw5KKgEgbaK/O1KpfhhNUSJG03gpzJ1KGXBpZL3RdTP9EcfXM5drBVo6VkFPhT
 nlLe8mbMcDG5DO9tVjtPlPjUBq/x24d3BOUH210bAtkOIoiUrpUAiWN2Sjfi8wcgEe1HDNu0YOdY0
 jb4TENFdfgTCreITSK0rqW1np7+sIjM9kSwXPhTwkeT71gQdQ7mol5sqhpp3/H/3kPKbJIpB8PAOB
 HmfQ1HYQ==;
Received: from 54-240-197-231.amazon.com ([54.240.197.231]
 helo=edge-m3-r3-159.e-iad51.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOKIG-0005jC-St; Fri, 02 Oct 2020 12:36:13 +0000
Message-ID: <38b94080aa2d616a0ecb98d5afcd7cbe9f69f9e8.camel@infradead.org>
Subject: [RFC][POC PATCH] Supporting >255 guest CPUs without interrupt
 remapping
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Date: Fri, 02 Oct 2020 13:36:11 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/x-pkcs7-signature";
 boundary="=-Unot8gwk2Y/+LrFNngEi"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1231::1;
 envelope-from=BATV+71a21e484f4bc027aef9+6249+infradead.org+dwmw2@merlin.srs.infradead.org;
 helo=merlin.infradead.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: x86 <x86@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-Unot8gwk2Y/+LrFNngEi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AFAICT there's not actually any good reason why guests can't use x2apic
and have more than 255 CPUs today, even without exposing interrupt
remapping to the guest.

The only issue is that guests can't direct external IOAPIC and MSI
interrupts at the higher APIC IDs. So what? A guest might have a
workload where it makes plenty of sense to use those extra CPUs and
just refrain from targeting external interrupts at them.

In fact, if you take a close look at the hyperv-iommu driver in the
Linux guest kernel, you'll note that it doesn't actually do any
remapping at all; all it does is return -EINVAL if asked to set
affinity to a CPU which can't be targeted.

For Linux at least, it should be fairly simple to have a per-IRQ
controller affinity limit, so it doesn't attempt to target CPUs it
can't reach.

But actually, it's really simple to extend the limit of reachable APICs
even without the complexity of adding a full vIOMMU.

There are 8 bits of extended destination ID in the IOAPIC RTE, which
maps to bits 11-4 of the MSI address. This was historically not used in
bare metal, but IRQ remapping now uses the lowest bit to indicate a
remappable format interrupt.

A VMM can use the other 7 bits to allow guests to target 15 bits of
APIC ID, which gives support for 32Ki vCPUs without needing to expose
IRQ remapping to the guest.

Here's a proof-of-concept hack, which I've tested with a Linux guest
that knows where to put the additional 7 bits in the IOAPIC RTE and MSI
message. At least IOAPIC and emulated AHCI (MSI) are working; I haven't
tested assigned PCI devices yet.

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 4eb2d77b87..b0f4b1a630 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/i386/apic_internal.h"
+#include "hw/i386/apic-msidef.h"
 #include "hw/pci/msi.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
@@ -183,6 +184,13 @@ static void kvm_send_msi(MSIMessage *msg)
 {
     int ret;
=20
+    /*
+     * The message has already passed through interrupt remapping if enabl=
ed,
+     * but the legacy extended destination ID in low bits still needs to b=
e
+     * handled.
+     */
+    msg->address =3D apic_convert_ext_dest_id(msg->address);
+
     ret =3D kvm_irqchip_send_msi(kvm_state, *msg);
     if (ret < 0) {
         fprintf(stderr, "KVM: injection failed, MSI lost (%s)\n",
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e87be5d29a..eb4901d6b7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -807,7 +807,7 @@ void pc_machine_done(Notifier *notifier, void *data)
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus)=
;
     }
=20
-    if (x86ms->apic_id_limit > 255 && !xen_enabled()) {
+    if (0 && x86ms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu =3D INTEL_IOMMU_DEVICE(x86_iommu_get_defaul=
t());
=20
         if (!iommu || !x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu)) ||
diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
index 420b41167d..b3e0da64a5 100644
--- a/include/hw/i386/apic-msidef.h
+++ b/include/hw/i386/apic-msidef.h
@@ -28,4 +28,20 @@
 #define MSI_ADDR_DEST_IDX_SHIFT         4
 #define  MSI_ADDR_DEST_ID_MASK          0x000ff000
=20
+static inline uint64_t apic_convert_ext_dest_id(uint64_t address)
+{
+        uint64_t ext_id =3D address & (0xff << MSI_ADDR_DEST_IDX_SHIFT);
+        /*
+         * If the remappable format bit is set, or the upper bits are
+         * already set in address_hi, or the low extended bits aren't
+         * there anyway, do nothing.
+         */
+        if (!ext_id || (ext_id & (1 << MSI_ADDR_DEST_IDX_SHIFT)) ||
+            (address >> 32))
+                return address;
+
+        address &=3D ~ext_id;
+        address |=3D ext_id << 35;
+        return address;
+}
 #endif /* HW_APIC_MSIDEF_H */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f6dae4cfb6..547a2faf72 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4589,13 +4589,11 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing=
_entry *route,
     X86IOMMUState *iommu =3D x86_iommu_get_default();
=20
     if (iommu) {
-        int ret;
-        MSIMessage src, dst;
         X86IOMMUClass *class =3D X86_IOMMU_DEVICE_GET_CLASS(iommu);
=20
-        if (!class->int_remap) {
-            return 0;
-        }
+        if (class->int_remap) {
+            int ret;
+            MSIMessage src, dst;
=20
             src.address =3D route->u.msi.address_hi;
             src.address <<=3D VTD_MSI_ADDR_HI_SHIFT;
@@ -4610,11 +4608,21 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing=
_entry *route,
                 return 1;
             }
=20
+            /*
+             * Handled untranslated compatibilty format interrupt with
+             * extended destination ID in the low bits 11-5. */
+            dst.address =3D apic_convert_ext_dest_id(dst.address);
+
             route->u.msi.address_hi =3D dst.address >> VTD_MSI_ADDR_HI_SHI=
FT;
             route->u.msi.address_lo =3D dst.address & VTD_MSI_ADDR_LO_MASK=
;
             route->u.msi.data =3D dst.data;
+            return 0;
+        }
     }
=20
+    address =3D apic_convert_ext_dest_id(address);
+    route->u.msi.address_hi =3D address >> VTD_MSI_ADDR_HI_SHIFT;
+    route->u.msi.address_lo =3D address & VTD_MSI_ADDR_LO_MASK;
     return 0;
 }
=20

--=-Unot8gwk2Y/+LrFNngEi
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAx
MDAyMTIzNjExWjAvBgkqhkiG9w0BCQQxIgQgTfYF338CfcJ1LBWaChi34HucuUKScjshLMOVLPI/
3/Ywgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAF9E+dwb1lNdC/MU0v2JqJwQpzHiiiyY+U9OpJ5KPDO4NzBKASiiOcWv+p/rR5VB
BPUlkWi+S5k6aRLzDcDnrz74yo3vHZ6tkS4gSUNHAWdPvyBpmJeHbAzul0gBXAoW9ahkOFWGM36u
uWU1nqXDG0vS9BEowM9/hC0ee6Oz108xxXF1REBU/S4rUaxrKfPYJLLr/s6SN17dX3bex97qKUim
Xd1o522n4pLufJC9TS7Iv3pUMLwcnTRqw7785ojqcrMXOtcwJRm8gN+hXxXMpJyeIKeYHFsxPobw
S5dJ8904y19wU7NnGGYjFIgHYMUVcWtOCjKNvdEKJcs18biEjFgAAAAAAAA=


--=-Unot8gwk2Y/+LrFNngEi--


