Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fG4CC-0007T5-1d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fG4B8-0007tF-2K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:06:27 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fG4B7-0007rZ-9f
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:05:21 -0400
Received: by mail-wm0-x241.google.com with SMTP id x12-v6so19553154wmc.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:05:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504210001.GB30250@redhat.com>
	<CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea788b49-07c7-f12f-2a17-98efb2ab6324@redhat.com>
Date: Tue, 8 May 2018 17:05:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 0/3] Document intent for
 supported build platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Dunlap <dunlapg@umich.edu>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>, Anthony Perard <anthony.perard@citrix.com>

On 08/05/2018 16:50, George Dunlap wrote:
> Tailing into that, with my CentOS package maintainer hat on: You said
> that the code in question compiled on RHEL 6 because RH had backported
> the function in question.  Will QEMU continue to actually compile on
> RHEL 6 / CentOS 6?  I.e., will configure be checking for that
> function, or only checking for the version number?

The latter, because we're also dropping all the compatibility code that
allowed QEMU to compile on older glib versions.

Paolo

> If the former, then the CentOS 6 Xen packages won't be affected.  If
> the latter, then at some point I'll have to stop updating the Xen
> version for CentOS 6 -- but as the CentOS 6 EOL is coming up in 2020,
> it shouldn't be too much of a hardship.
