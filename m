Received: from eggs.gnu.org ([2001:4830:134:3::10]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRVE-0000AE-GF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRVD-0004H7-OI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:37:00 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cWRVD-0004Gm-GT
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:36:59 -0500
Received: by mail-oi0-x243.google.com with SMTP id j15so16183798oih.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:36:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148536527026.27.12814124354919992023@eba24e3a0d7f>
References: <1485365075-32702-1-git-send-email-phil@philjordan.eu>
	<148536527026.27.12814124354919992023@eba24e3a0d7f>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 25 Jan 2017 18:36:38 +0100
Message-ID: <CAAibmn0YQYZKv_DfqmZ9fkW6nC=rJrrEnyadhV1QOLrLzs2f6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, "Gabriel L. Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>

On 25 January 2017 at 18:27,  <no-reply@patchew.org> wrote:
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Subject: [Qemu-devel] [PATCH v3] hw/usb/dev-hid: Improve guest compatibility of usb-tablet
> Message-id: 1485365075-32702-1-git-send-email-phil@philjordan.eu
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: hw/usb/dev-hid: Improve guest compatibility of usb-tablet...
> ERROR: code indent should never use tabs
> #43: FILE: hw/usb/dev-hid.c:490:
> +    0x09, 0x02,^I^I/* Usage (Mouse) */$

Interestingly, the surrounding array initialisation already uses tabs,
so replacing them with spaces on only the line I edited seems wrong as
it'll mis-render in editors configured with a different tab width.
Please let me know if I need to take action on this issue, and if so
what to do. (I can add a whitespace-only patch to fix the surrounding
area, for example. Coding guidelines suggest this might not be
desirable though.)
