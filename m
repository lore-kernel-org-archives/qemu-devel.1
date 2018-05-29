Received: from eggs.gnu.org ([2001:4830:134:3::10]:37671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNinp-0007nR-Am
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNink-0007kx-H9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:52:57 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fNink-0007kb-CU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:52:52 -0400
Received: by mail-it0-x241.google.com with SMTP id e185-v6so29657871ita.0
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 10:52:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180525102636.13136-1-peter.maydell@linaro.org>
Date: Tue, 29 May 2018 13:52:49 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3BA09EF-3D8A-4C7A-94C8-A71DC919FDEF@gmail.com>
References: <20180525102636.13136-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Suppress
 NSFileHandlingPanelOKButton deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org


> On May 25, 2018, at 6:26 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
> would rather you use NSModalResponseOK, which was introduced in OS =
10.9.
> Use the recommended new constant name, with a backward compatibility
> define if we're building on an older OSX.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested on 10.13; I don't hvae anything older to test on.
>=20
> ui/cocoa.m | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 110b393e4e..f5ecd66fd3 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -79,6 +79,13 @@
> #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
> #define NSWindowStyleMaskTitled         NSTitledWindowMask
> #endif
> +/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
> + * NSModalResponseOK, which was introduced in 10.9. Define
> + * it for older versions.
> + */
> +#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
> +#define NSModalResponseOK NSFileHandlingPanelOKButton
> +#endif
>=20
> //#define DEBUG
>=20
> @@ -1218,7 +1225,7 @@ QemuCocoaView *cocoaView;
>     [openPanel setCanChooseFiles: YES];
>     [openPanel setAllowsMultipleSelection: NO];
>     [openPanel setAllowedFileTypes: supportedImageFileTypes];
> -    if([openPanel runModal] =3D=3D NSFileHandlingPanelOKButton) {
> +    if([openPanel runModal] =3D=3D NSModalResponseOK) {
>         NSString * file =3D [[[openPanel URLs] objectAtIndex: 0] =
path];
>         if(file =3D=3D nil) {
>             NSBeep();
> --=20
> 2.17.0
>=20

Sorry but this patch does not work with Mac OS 10.6. The =
MAC_OS_X_VERSION_10_9
constant is not defined. I did make a patch that does work. It will be =
sent shortly.
