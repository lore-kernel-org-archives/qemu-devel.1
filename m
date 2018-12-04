Received: from eggs.gnu.org ([2001:4830:134:3::10]:55357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUEb3-0004C6-Jm
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUEXv-00035v-7t
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:31:47 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gUEXv-000343-0x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:31:43 -0500
Date: Tue, 4 Dec 2018 12:31:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181204173138.GA15610@flamenco>
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org> <87h8ft3295.fsf@linaro.org>
	<e39db85e-52b5-bdc8-d9a7-e3a14f78ce4b@linaro.org>
	<87ftvd2ycv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftvd2ycv.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Tue, Dec 04, 2018 at 13:52:16 +0000, Alex Bennée wrote:
> > We could always
> >
> > #ifdef __FAST_MATH__
> > #error "Silliness like this will get you nowhere"
> > #endif
> 
> Emilio, are you happy to add that guard with a suitable pithy comment?

Isn't it better to just disable hardfloat then?

--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,7 +220,7 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(__FAST_MATH__)
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else

Or perhaps disable it, as well as issue a #warning?

		E.
