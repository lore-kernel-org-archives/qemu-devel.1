Received: from eggs.gnu.org ([209.51.188.92]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0ihL-00062W-PM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0ihJ-0007Iv-Vc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:11:43 -0500
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15464582-e8a6-6654-7679-15d87c10af38@redhat.com>
Date: Mon, 4 Mar 2019 09:11:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190301174806.GN21251@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [libvirt] [PATCH 1/2] numa: deprecate
 'mem' parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 01/03/2019 18.48, Daniel P. Berrang=C3=A9 wrote:
[...]
> So I think this patch has to be dropped & replaced with one that
> simply documents that memdev syntax is preferred.

That's definitely not enough. I've had a couple of cases already where
we documented that certain options should not be used anymore, and
people simply ignored it (aka. if it ain't broken, don't do any change).
Then they just started to complain when I really tried to remove the
option after the deprecation period.

So Igor, if you can not officially deprecate these things here yet, you
should at least make sure that they can not be used with new machine
types anymore. Then, after a couple of years, when we feel sure that
there are only some few or no people left who still use it with the old
machine types, we can start to discuss the deprecation process again, I
think.

 Thomas
