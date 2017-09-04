Received: from eggs.gnu.org ([2001:4830:134:3::10]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dovoM-0001PH-78
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dovoH-00066v-Ho
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:09:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dovoH-00065w-Cu
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:09:21 -0400
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
Date: Mon, 4 Sep 2017 20:09:17 +0200
MIME-Version: 1.0
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

On 04.09.2017 19:19, Peter Maydell wrote:
> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.

We just added this some weeks ago to our qemu-doc.texi:

"Prior to the 2.10.0 release there was no official policy on how long
features would be deprecated prior to their removal, nor any documented
list of which features were deprecated. Thus any features deprecated
prior to 2.10.0 will be treated as if they were first deprecated in the
2.10.0 release."

Should we maybe wait two more releases (for version 3.0 ;-)) 'till we
remove it?

Anyway, the patch looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
