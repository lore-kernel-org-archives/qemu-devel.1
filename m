Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNj7E-0006ac-83
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNj7A-0000UM-QX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:13:00 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fNj7A-0000U7-LR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:56 -0400
Received: by mail-io0-x241.google.com with SMTP id d73-v6so18696415iog.3
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:12:56 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA-E10Fp7MjgFpSoMTWyn5Wf0OTvSLWJC2LKnZJBT+-Gqw@mail.gmail.com>
Date: Tue, 29 May 2018 14:12:54 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <57C40AB5-274A-4809-813E-7EA9AA28F07A@gmail.com>
References: <20180529180813.2647-1-programmingkidx@gmail.com>
	<CAFEAcA-E10Fp7MjgFpSoMTWyn5Wf0OTvSLWJC2LKnZJBT+-Gqw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Suppress
 NSFileHandlingPanelOKButton depreciation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>


> On May 29, 2018, at 2:11 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 29 May 2018 at 19:08, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
>> would rather you use NSModalResponseOK, which was introduced in OS =
10.9.
>> Use the recommended new constant name, with a backward compatibility
>> define if we're building on an older OSX.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> ui/cocoa.m | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 110b393..c9473f0 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -79,6 +79,13 @@
>> #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
>> #define NSWindowStyleMaskTitled         NSTitledWindowMask
>> #endif
>> +/* 10.13 deprecates NSFileHandlingPanelOKButton in favor of
>> + * NSModalResponseOK, which was introduced in 10.9. Define
>> + * it for older versions.
>> + */
>> +#if !defined MAC_OS_X_VERSION_10_9 || MAC_OS_X_VERSION_MAX_ALLOWED < =
MAC_OS_X_VERSION_10_9
>> +#define NSModalResponseOK NSFileHandlingPanelOKButton
>> +#endif
>=20
> We should just define MAC_OS_X_VERSION_10_9 if it's not
> defined, the same way we do for the 10_5/10_6/10_10/10_12
> constants. I'll respin my patch.

Sounds like a good idea.=
