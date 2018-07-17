Received: from eggs.gnu.org ([2001:4830:134:3::10]:34011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ffKsN-0007Gt-8a
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1ffKsJ-0002AZ-9t
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:58:26 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1ffKsI-0002AK-Q3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:58:23 -0400
Received: by mail-ed1-x541.google.com with SMTP id e19-v6so413619edq.7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 00:58:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153177149044.7766.17760513270449969196@sif>
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-3-sameeh@daynix.com>
	<153177149044.7766.17760513270449969196@sif>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Jul 2018 10:58:21 +0300
Message-ID: <CAKPgXcGftpxGJy+pRdcQ-iE0NE2McH6Mw-jO1BOP6b3ux=08dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] qga-win: fsinfo: pci-info: allow
 partial info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Mon, Jul 16, 2018 at 11:04 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2018-06-26 10:10:38)
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > The call to SetupDiGetDeviceRegistryProperty might fail because the
> > value doesn't exist in the registry, in this case we shouldn't exit from
> > the loop but instead continue to look for other available values in the
> > registry and set this value as unavailable (-1).
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>
> The values I'm seeing look off:
>
> win7:
>
> {'execute':'guest-get-fsinfo','arguments':{}}
>
> {"return": [{"name":
> "\\\\?\\Volume{2823bc2b-b90f-11e7-9ea5-806e6f6e6963}\\", "total-bytes":
> 316628992, "mountpoint": "E:\\", "disk": [{"bus-type": "ide", "bus": 0,
> "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": -1,
> "function": -1}, "target": 0}], "used-bytes": 316628992, "type":
> "CDFS"}, {"name":
> "\\\\?\\Volume{a1ed8064-3f4a-11e1-972d-806e6f6e6963}\\", "total-bytes":
> 21367877632, "mountpoint": "C:\\", "disk": [{"bus-type": "scsi", "bus":
> 0, "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": 0,
> "function": 2}, "target": 0}], "used-bytes": 19656269824, "type":
> "NTFS"}, {"name":
> "\\\\?\\Volume{a1ed8063-3f4a-11e1-972d-806e6f6e6963}\\", "mountpoint":
> "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0, "unit": 0,
> "pci-controller": {"bus": -1, "slot": -1, "domain": 0, "function": 1},
> "target": 0}], "type": "NTFS"}]}
>
> win10:
>
> {'execute':'guest-get-fsinfo','arguments':{}}
>
> {"return": [{"name":
> "\\\\?\\Volume{83835b2d-0032-11e6-a84f-806e6f6e6963}\\", "total-bytes":
> 160755712, "mountpoint": "D:\\", "disk": [{"bus-type": "ide", "bus": 0,
> "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": -1,
> "function": -1}, "target": 0}], "used-bytes": 160755712, "type":
> "CDFS"}, {"name":
> "\\\\?\\Volume{2ea839c6-0000-0000-0000-80620c000000}\\", "mountpoint":
> "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0, "unit": 0,
> "pci-controller": {"bus": -1, "slot": -1, "domain": 0, "function": 3},
> "target": 0}], "type": "NTFS"}, {"name":
> "\\\\?\\Volume{2ea839c6-0000-0000-0000-501f00000000}\\", "total-bytes":
> 52665839616, "mountpoint": "C:\\", "disk": [{"bus-type": "scsi", "bus":
> 0, "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": 0,
> "function": 2}, "target": 0}], "used-bytes": 29645811712, "type":
> "NTFS"}, {"name":
> "\\\\?\\Volume{2ea839c6-0000-0000-0000-100000000000}\\", "mountpoint":
> "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0, "unit": 0,
> "pci-controller": {"bus": -1, "slot": -1, "domain": 0, "function": 1},
> "target": 0}], "type": "NTFS"}]}
>
> If any one of domain/bus/slot/func fail, we should initialize everything
> to -1 since we can't partially report a PCI address. The fact that we
> get partial success makes me think SPDRP_ADDRESS, SPDRP_UI_NUMBER, etc.
> aren't reporting what we expect they should. The documentation seems
> a bit nebulous. Also I'm not using multifunction to the non-0 function
> values seem off.
>


>
> Do you know of anyone manually setting CONFIG_QGA_NTDDSCSI in practice?
>
Yes, I am using it actually.

> It's been left disabled in configure (left misnamed as CONFIG_QGA_NTDDDISK
> due to some problems that popped up when we tried to enable it that I
> don't quite recall, maybe similar issues to what you're seeing). I'm
> starting to think it's better to leave this for 3.1 since it's not
> technically a supported feature yet and may need some reworking outside
> of the issue you were originally addressing.
>
No problem it can wait for 3.1.

>
> > ---
> >  qga/commands-win32.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index c5f1c884e1..55e460dee3 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -505,7 +505,8 @@ static GuestPCIAddress *get_pci_info(char *guid,
> Error **errp)
> >
> >      dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
> >      for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data);
> i++) {
> > -        DWORD addr, bus, slot, func, dev, data, size2;
> > +        DWORD addr, bus, slot, data, size2;
> > +        int func, dev;
> >          while (!SetupDiGetDeviceRegistryProperty(dev_info,
> &dev_info_data,
> >
> SPDRP_PHYSICAL_DEVICE_OBJECT_NAME,
> >                                              &data, (PBYTE)buffer, size,
> > @@ -535,21 +536,21 @@ static GuestPCIAddress *get_pci_info(char *guid,
> Error **errp)
> >           */
> >          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> >                     SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
> > -            break;
> > +            bus = -1;
> >          }
> >
> >          /* The function retrieves the device's address. This value will
> be
> >           * transformed into device function and number */
> >          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> >                     SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
> > -            break;
> > +            addr = -1;
> >          }
> >
> >          /* This call returns UINumber of DEVICE_CAPABILITIES structure.
> >           * This number is typically a user-perceived slot number. */
> >          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> >                     SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
> > -            break;
> > +            slot = -1;
> >          }
> >
> >          /* SetupApi gives us the same information as driver with
> > @@ -559,12 +560,12 @@ static GuestPCIAddress *get_pci_info(char *guid,
> Error **errp)
> >           * DeviceNumber = (USHORT)(((propertyAddress) >> 16) &
> 0x0000FFFF);
> >           * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
> >
> > -        func = addr & 0x0000FFFF;
> > -        dev = (addr >> 16) & 0x0000FFFF;
> > +        func = ((int) addr == -1) ? -1 : addr & 0x0000FFFF;
> > +        dev = ((int) addr == -1) ? -1 : (addr >> 16) & 0x0000FFFF;
> >          pci->domain = dev;
> > -        pci->slot = slot;
> > +        pci->slot = (int) slot;
> >          pci->function = func;
> > -        pci->bus = bus;
> > +        pci->bus = (int) bus;
> >          break;
> >      }
> >
> > --
> > 2.13.6
> >
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
