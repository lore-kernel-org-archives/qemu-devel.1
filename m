Received: from eggs.gnu.org ([2001:4830:134:3::10]:45967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWYsA-0005oz-Ga
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWYs7-0004RV-Eo
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:29:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWYs7-0004RP-9Y
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:29:07 -0500
Date: Thu, 26 Jan 2017 09:29:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126012903.GA6879@lemon>
References: <1485365075-32702-1-git-send-email-phil@philjordan.eu>
	<148536527026.27.12814124354919992023@eba24e3a0d7f>
	<CAAibmn0YQYZKv_DfqmZ9fkW6nC=rJrrEnyadhV1QOLrLzs2f6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAibmn0YQYZKv_DfqmZ9fkW6nC=rJrrEnyadhV1QOLrLzs2f6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/dev-hid: Improve guest
 compatibility of usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, "Gabriel L. Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 01/25 18:36, Phil Dennis-Jordan wrote:
> On 25 January 2017 at 18:27,  <no-reply@patchew.org> wrote:
> > Your series seems to have some coding style problems. See output below for
> > more information:
> >
> > Type: series
> > Subject: [Qemu-devel] [PATCH v3] hw/usb/dev-hid: Improve guest compatibility of usb-tablet
> > Message-id: 1485365075-32702-1-git-send-email-phil@philjordan.eu
> >
> > === OUTPUT BEGIN ===
> > Checking PATCH 1/1: hw/usb/dev-hid: Improve guest compatibility of usb-tablet...
> > ERROR: code indent should never use tabs
> > #43: FILE: hw/usb/dev-hid.c:490:
> > +    0x09, 0x02,^I^I/* Usage (Mouse) */$
> 
> Interestingly, the surrounding array initialisation already uses tabs,
> so replacing them with spaces on only the line I edited seems wrong as
> it'll mis-render in editors configured with a different tab width.
> Please let me know if I need to take action on this issue, and if so
> what to do. (I can add a whitespace-only patch to fix the surrounding
> area, for example. Coding guidelines suggest this might not be
> desirable though.)

File level tab consistency should override checkpatch.pl in this case, and as
you said whitespace patches are usually not advisable. Let's just ignore the
complain.

Fam
