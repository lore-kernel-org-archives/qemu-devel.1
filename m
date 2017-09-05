Received: from eggs.gnu.org ([2001:4830:134:3::10]:35435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dp8qW-0002aP-Am
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dp8qM-0007IH-SH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dp8qM-0007HP-Lp
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:04:22 -0400
Date: Tue, 5 Sep 2017 09:04:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170905080418.GA311@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
	<d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

On Mon, Sep 04, 2017 at 08:09:17PM +0200, Thomas Huth wrote:
> On 04.09.2017 19:19, Peter Maydell wrote:
> > Nobody has mentioned AIX host support on the mailing list for years,
> > and we have no test systems for it so it is most likely broken.
> > We've advertised in configure for two releases now that we plan
> > to drop support for this host OS, and have had no complaints.
> 
> We just added this some weeks ago to our qemu-doc.texi:
> 
> "Prior to the 2.10.0 release there was no official policy on how long
> features would be deprecated prior to their removal, nor any documented
> list of which features were deprecated. Thus any features deprecated
> prior to 2.10.0 will be treated as if they were first deprecated in the
> 2.10.0 release."
> 
> Should we maybe wait two more releases (for version 3.0 ;-)) 'till we
> remove it?

The deprecation policy is for features which currently work and which we
expect to have actual users. Neither is the case with AIX support, so I
don't see any reason to keep it longer.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
