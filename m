Received: from eggs.gnu.org ([2001:4830:134:3::10]:58741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGpoz-0000FF-C8
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGpot-0001OK-Ho
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGpot-0001O4-C2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:20:47 -0500
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-21-git-send-email-thuth@redhat.com>
	<8581a7a9-9596-7f1f-ffe0-d87181221109@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cb96029-9bda-713d-c848-3a2a11d966f1@redhat.com>
Date: Tue, 13 Dec 2016 17:20:35 +0100
MIME-Version: 1.0
In-Reply-To: <8581a7a9-9596-7f1f-ffe0-d87181221109@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/20] Makefile.target: Targets now have to
 reside in the target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>



On 09/12/2016 13:27, Laurent Vivier wrote:
> Le 09/12/2016 =C3=A0 13:17, Thomas Huth a =C3=A9crit :
>> Now that all target CPU folders have been moved to target/, we
>> do not need to support the old naming scheme of target-xxx
>> anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Makefile.target | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index 90b25ae..1da789c 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -7,11 +7,7 @@ include config-target.mak
>>  include config-devices.mak
>>  include $(SRC_PATH)/rules.mak
>> =20
>> -ifneq ($(wildcard $(SRC_PATH)/target/$(TARGET_BASE_ARCH)),)
>>  TARGET_FOLDER=3Dtarget/$(TARGET_BASE_ARCH)
>> -else
>> -TARGET_FOLDER=3Dtarget-$(TARGET_BASE_ARCH)
>> -endif
>> =20
>>  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
>>  ifdef CONFIG_LINUX
>>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20

Please undo the introduction of TARGET_FOLDER completely.

I would just squash all 20 patches together, and send a pull request.

Paolo
