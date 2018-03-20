Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mimu@linux.vnet.ibm.com>) id 1eyIqK-0006vG-Mz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mimu@linux.vnet.ibm.com>) id 1eyIqJ-0001hf-01
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:06:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mimu@linux.vnet.ibm.com>)
	id 1eyIqI-0001fM-Pc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:06:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KF4Y6G135045
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:06:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gu1e19ykr-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:06:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mimu@linux.vnet.ibm.com>;
	Tue, 20 Mar 2018 15:06:16 -0000
Reply-To: mimu@linux.vnet.ibm.com
References: <20180320130702.188689-1-borntraeger@de.ibm.com>
	<c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
From: Michael Mueller <mimu@linux.vnet.ibm.com>
Date: Tue, 20 Mar 2018 16:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
Content-Type: multipart/mixed; boundary="------------34A95B821282D6B08B294109"
Content-Language: en-US
Message-Id: <760d8180-a6f8-ec8e-fa62-7d2255c9b7a7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/cpumodel: fix feature groups and
 breakage of MSA8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------34A95B821282D6B08B294109
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I could imagine something like this, see attachment.

Michael

On 20.03.18 14:17, Christian Borntraeger wrote:
> David, Jason, Michael,
> 
> the cpumodel code is somewhat fragile as we have to add maintain things
> in multiple places. I would like to have more robust code, e.g. by either
> generating more or by having build bug_ons or something like that.
> Any idea is highly welcome.
> 
> Christian
> 
> 
> On 03/20/2018 02:07 PM, Christian Borntraeger wrote:
>> Since commit 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions
>> for Multiple-epoch facility") -cpu help no longer shows the MSA8
>> feature group. Turns out that we forgot to add the new MEPOCH_PTFF
>> group enum.
>>
>> Fixes: 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions for Multiple-epoch facility")
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   target/s390x/cpu_features.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
>> index e306aa7ab2..968b12fdfe 100644
>> --- a/target/s390x/cpu_features.h
>> +++ b/target/s390x/cpu_features.h
>> @@ -78,6 +78,7 @@ typedef enum {
>>       S390_FEAT_GROUP_MSA_EXT_6,
>>       S390_FEAT_GROUP_MSA_EXT_7,
>>       S390_FEAT_GROUP_MSA_EXT_8,
>> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>>       S390_FEAT_GROUP_MAX,
>>   } S390FeatGroup;
>>
> 
> 

--------------34A95B821282D6B08B294109
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-target-s390x-enum-type-S390FeatGroup-now-gets-genera.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-target-s390x-enum-type-S390FeatGroup-now-gets-genera.pa";
 filename*1="tch"

RnJvbSA5NzhkMGI0ODA4MjQyNDg1ODYxNDllZDY3ZGNhN2IzMWM2YTVlNWQ4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIE11ZWxsZXIgPG1pbXVAbGludXgudm5l
dC5pYm0uY29tPgpEYXRlOiBUdWUsIDIwIE1hciAyMDE4IDE1OjU2OjE4ICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gdGFyZ2V0L3MzOTB4OiBlbnVtIHR5cGUgUzM5MEZlYXRHcm91cCBub3cg
Z2V0cyBnZW5lcmF0ZWQKClRoZSBlbnVtZXJhdGlvbiB0eXBlIFMzOTBGZWF0R3JvdXAgaXMg
bm93IGdlcmVyYXRlZCBhcyB3ZWxsLgpUaGlzIHNoYWxsIHNpbXBsaWZ5IHRoZSBkZWZpbml0
aW9uIG9mIG5ldyBmZWF0dXJlIGdyb3Vwcwp3aXRob3V0IG1vZGlmeWluZyBleGlzdGluZyBj
b2RlLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBNdWVsbGVyIDxtaW11QGxpbnV4LnZuZXQu
aWJtLmNvbT4KLS0tCiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzLmMgfCAgMSAtCiB0YXJn
ZXQvczM5MHgvY3B1X2ZlYXR1cmVzLmggfCAxOCArLS0tLS0tLS0tLS0tLS0tLS0KIHRhcmdl
dC9zMzkweC9nZW4tZmVhdHVyZXMuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQogMyBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS90YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzLmMgYi90YXJnZXQvczM5MHgvY3B1X2Zl
YXR1cmVzLmMKaW5kZXggM2I5ZTI3NDVlOS4uZDYyM2RiMzRhNiAxMDA2NDQKLS0tIGEvdGFy
Z2V0L3MzOTB4L2NwdV9mZWF0dXJlcy5jCisrKyBiL3RhcmdldC9zMzkweC9jcHVfZmVhdHVy
ZXMuYwpAQCAtMTMsNyArMTMsNiBAQAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKICNpbmNs
dWRlICJxZW11L21vZHVsZS5oIgogI2luY2x1ZGUgImNwdV9mZWF0dXJlcy5oIgotI2luY2x1
ZGUgImdlbi1mZWF0dXJlcy5oIgogCiAjZGVmaW5lIEZFQVRfSU5JVChfbmFtZSwgX3R5cGUs
IF9iaXQsIF9kZXNjKSBcCiAgICAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKZGlmZiAtLWdpdCBhL3RhcmdldC9zMzkweC9jcHVfZmVhdHVy
ZXMuaCBiL3RhcmdldC9zMzkweC9jcHVfZmVhdHVyZXMuaAppbmRleCBlMzA2YWE3YWIyLi5l
ZmZlNzkwMjcxIDEwMDY0NAotLS0gYS90YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzLmgKKysr
IGIvdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlcy5oCkBAIC0xNiw2ICsxNiw3IEBACiAKICNp
bmNsdWRlICJxZW11L2JpdG1hcC5oIgogI2luY2x1ZGUgImNwdV9mZWF0dXJlc19kZWYuaCIK
KyNpbmNsdWRlICJnZW4tZmVhdHVyZXMuaCIKIAogLyogQ1BVIGZlYXR1cmVzIGFyZSBhbm5v
dW5jZWQgdmlhIGRpZmZlcmVudCB3YXlzICovCiB0eXBlZGVmIGVudW0gewpAQCAtNjQsMjMg
KzY1LDYgQEAgdm9pZCBzMzkwX2FkZF9mcm9tX2ZlYXRfYmxvY2soUzM5MEZlYXRCaXRtYXAg
ZmVhdHVyZXMsIFMzOTBGZWF0VHlwZSB0eXBlLAogdm9pZCBzMzkwX2ZlYXRfYml0bWFwX3Rv
X2FzY2lpKGNvbnN0IFMzOTBGZWF0Qml0bWFwIGZlYXR1cmVzLCB2b2lkICpvcGFxdWUsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAoKmZuKShjb25zdCBjaGFyICpu
YW1lLCB2b2lkICpvcGFxdWUpKTsKIAotLyogc3RhdGljIGdyb3VwcyB0aGF0IHdpbGwgbmV2
ZXIgY2hhbmdlICovCi10eXBlZGVmIGVudW0gewotICAgIFMzOTBfRkVBVF9HUk9VUF9QTE8s
Ci0gICAgUzM5MF9GRUFUX0dST1VQX1RPRF9DTE9DS19TVEVFUklORywKLSAgICBTMzkwX0ZF
QVRfR1JPVVBfR0VOMTNfUFRGRl9FTkgsCi0gICAgUzM5MF9GRUFUX0dST1VQX01TQSwKLSAg
ICBTMzkwX0ZFQVRfR1JPVVBfTVNBX0VYVF8xLAotICAgIFMzOTBfRkVBVF9HUk9VUF9NU0Ff
RVhUXzIsCi0gICAgUzM5MF9GRUFUX0dST1VQX01TQV9FWFRfMywKLSAgICBTMzkwX0ZFQVRf
R1JPVVBfTVNBX0VYVF80LAotICAgIFMzOTBfRkVBVF9HUk9VUF9NU0FfRVhUXzUsCi0gICAg
UzM5MF9GRUFUX0dST1VQX01TQV9FWFRfNiwKLSAgICBTMzkwX0ZFQVRfR1JPVVBfTVNBX0VY
VF83LAotICAgIFMzOTBfRkVBVF9HUk9VUF9NU0FfRVhUXzgsCi0gICAgUzM5MF9GRUFUX0dS
T1VQX01BWCwKLX0gUzM5MEZlYXRHcm91cDsKLQogLyogRGVmaW5pdGlvbiBvZiBhIENQVSBm
ZWF0dXJlIGdyb3VwICovCiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgY29uc3QgY2hhciAqbmFt
ZTsgICAgICAgLyogbmFtZSBleHBvc2VkIHRvIHRoZSB1c2VyICovCmRpZmYgLS1naXQgYS90
YXJnZXQvczM5MHgvZ2VuLWZlYXR1cmVzLmMgYi90YXJnZXQvczM5MHgvZ2VuLWZlYXR1cmVz
LmMKaW5kZXggMGNkYmMxNTM3OC4uOTQ2MDJmNDM4NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Mz
OTB4L2dlbi1mZWF0dXJlcy5jCisrKyBiL3RhcmdldC9zMzkweC9nZW4tZmVhdHVyZXMuYwpA
QCAtNjU5LDYgKzY1OSw3IEBAIHN0YXRpYyBDcHVGZWF0RGVmU3BlYyBDcHVGZWF0RGVmW10g
PSB7CiAjZGVmaW5lIEZFQVRfR1JPVVBfSU5JVElBTElaRVIoX25hbWUpICAgICAgICAgICAg
ICAgICAgXAogICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKICAgICAgICAgLm5hbWUgPSAiUzM5MF9GRUFUX0dST1VQX0xJU1RfIiAj
X25hbWUsICAgICAgICBcCisgICAgICAgIC5lbnVtX25hbWUgPSAiUzM5MF9GRUFUX0dST1VQ
XyIgI19uYW1lLCAgICAgICAgXAogICAgICAgICAuYml0cyA9ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgIHsgLmRhdGEgPSBncm91cF8j
I19uYW1lLCAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgIC5sZW4gPSBBUlJB
WV9TSVpFKGdyb3VwXyMjX25hbWUpIH0sICAgICAgXApAQCAtNjY2LDYgKzY2Nyw3IEBAIHN0
YXRpYyBDcHVGZWF0RGVmU3BlYyBDcHVGZWF0RGVmW10gPSB7CiAKIHR5cGVkZWYgc3RydWN0
IHsKICAgICBjb25zdCBjaGFyICpuYW1lOworICAgIGNvbnN0IGNoYXIgKmVudW1fbmFtZTsK
ICAgICBCaXRTcGVjIGJpdHM7CiB9IEZlYXRHcm91cERlZlNwZWM7CiAKQEAgLTY3Niw3ICs2
NzgsNiBAQCBzdGF0aWMgRmVhdEdyb3VwRGVmU3BlYyBGZWF0R3JvdXBEZWZbXSA9IHsKICAg
ICBGRUFUX0dST1VQX0lOSVRJQUxJWkVSKFBMTyksCiAgICAgRkVBVF9HUk9VUF9JTklUSUFM
SVpFUihUT0RfQ0xPQ0tfU1RFRVJJTkcpLAogICAgIEZFQVRfR1JPVVBfSU5JVElBTElaRVIo
R0VOMTNfUFRGRiksCi0gICAgRkVBVF9HUk9VUF9JTklUSUFMSVpFUihNVUxUSVBMRV9FUE9D
SF9QVEZGKSwKICAgICBGRUFUX0dST1VQX0lOSVRJQUxJWkVSKE1TQSksCiAgICAgRkVBVF9H
Uk9VUF9JTklUSUFMSVpFUihNU0FfRVhUXzEpLAogICAgIEZFQVRfR1JPVVBfSU5JVElBTEla
RVIoTVNBX0VYVF8yKSwKQEAgLTY4Niw2ICs2ODcsNyBAQCBzdGF0aWMgRmVhdEdyb3VwRGVm
U3BlYyBGZWF0R3JvdXBEZWZbXSA9IHsKICAgICBGRUFUX0dST1VQX0lOSVRJQUxJWkVSKE1T
QV9FWFRfNiksCiAgICAgRkVBVF9HUk9VUF9JTklUSUFMSVpFUihNU0FfRVhUXzcpLAogICAg
IEZFQVRfR1JPVVBfSU5JVElBTElaRVIoTVNBX0VYVF84KSwKKyAgICBGRUFUX0dST1VQX0lO
SVRJQUxJWkVSKE1VTFRJUExFX0VQT0NIX1BURkYpLAogfTsKIAogI2RlZmluZSBRRU1VX0ZF
QVRfSU5JVElBTElaRVIoX25hbWUpICAgICAgICAgICAgICAgICAgIFwKQEAgLTgwOCw2ICs4
MTAsMTkgQEAgc3RhdGljIHZvaWQgcHJpbnRfZmVhdHVyZV9ncm91cF9kZWZzKHZvaWQpCiAg
ICAgfQogfQogCitzdGF0aWMgdm9pZCBwcmludF9mZWF0dXJlX2dyb3VwX2VudW1fdHlwZSh2
b2lkKQoreworICAgIGludCBpOworCisgICAgcHJpbnRmKCJcbi8qIENQVSBmZWF0dXJlIGdy
b3VwIGVudW0gdHlwZSAqL1xuIik7CisgICAgcHJpbnRmKCJ0eXBlZGVmIGVudW0ge1xuIik7
CisgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoRmVhdEdyb3VwRGVmKTsgaSsrKSB7
CisgICAgICAgIHByaW50ZigiXHQlcyxcbiIsIEZlYXRHcm91cERlZltpXS5lbnVtX25hbWUp
OworICAgIH0KKyAgICBwcmludGYoIlx0UzM5MF9GRUFUX0dST1VQX01BWCxcbiIpOworICAg
IHByaW50ZigifSBTMzkwRmVhdEdyb3VwO1xuIik7Cit9CisKIGludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pCiB7CiAgICAgcHJpbnRmKCIvKlxuIgpAQCAtODI0LDYgKzgzOSw3
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgcHJpbnRfZmVhdHVy
ZV9kZWZzKCk7CiAgICAgcHJpbnRfZmVhdHVyZV9ncm91cF9kZWZzKCk7CiAgICAgcHJpbnRf
cWVtdV9mZWF0dXJlX2RlZnMoKTsKKyAgICBwcmludF9mZWF0dXJlX2dyb3VwX2VudW1fdHlw
ZSgpOwogICAgIHByaW50ZigiXG4jZW5kaWZcbiIpOwogICAgIHJldHVybiAwOwogfQotLSAK
Mi4xMy40Cgo=
--------------34A95B821282D6B08B294109--
