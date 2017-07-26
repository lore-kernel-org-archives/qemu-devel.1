Received: from eggs.gnu.org ([2001:4830:134:3::10]:35753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daL4P-0002lP-Ih
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daL4L-0001Mw-WE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daL4L-0001K3-Gu
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:05:37 -0400
Date: Wed, 26 Jul 2017 13:05:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726120529.GG7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
	<20170726112826.GE7620@redhat.com>
	<1501069447.29903.4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1501069447.29903.4.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jul 26, 2017 at 01:44:07PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > qcodes as currently defined cover only a subset of the AT set1
> > scancodes,
> > so we need to define countless more qcodes before we consider
> > converting
> > UIs to use qcodes.
> > 
> > Aside from the pause/break bug, the changes to ps2 driver to round
> > trip
> > via qcodes have now made it impossible to send a large number of key
> > sequences to the guest OS :-( Admittedly the missing key codes are
> > not
> > so commonly used, but it is still a notable regression in
> > functionality
> > today
> 
> My keymap branch carries fixes for that now:
> https://www.kraxel.org/cgit/qemu/log/?h=work/xkbcommon
> 
> For your keycodemapdb patches I'd suggest to cherry-pick at least the
> "ui: move qemu_input_linux_to_qcode()" patch.

FYI, after adding qcodes to the keycodemapdb, (but not having picked
your branch), I see 131 keys where there is a known AT set 1 scancode,
but no corresponding QKeyCode.

I'll happily add the rest of them if you want (attaching the list)

> Then have sdl + gtk generate linux evdev codes using keycodemapdb, map
> that to qcodes using qemu_input_linux_to_qcode(), submit qcodes to the
> qemu input layer.

I was actually just going add an entry for QKeyCode names to the
keycodemapdb, so we can convert straight to that, and also let
us auto-generate the qemu_input_linux_to_qcode() table.

Strangely there is no Linux key code defined for AltGr, so if we
map via Linux key codes, we would loose ability to send AltGr

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="missing.txt"

      Linux Key Name    AT Set 1 scancode
                                     0x54                     
  KEY_ZENKAKUHANKAKU                 0x76                     
        KEY_KATAKANA                 0x78                     
KEY_KATAKANAHIRAGANA                 0x70                     
        KEY_MUHENKAN                 0x7b                     
       KEY_KPJPCOMMA                 0x5c                     
        KEY_LINEFEED                 0x5b                     
           KEY_MACRO               0xe06f                     
            KEY_MUTE               0xe020                     
      KEY_VOLUMEDOWN               0xe02e                     
        KEY_VOLUMEUP               0xe030                     
           KEY_POWER               0xe05e                     
         KEY_KPEQUAL                 0x59                     
     KEY_KPPLUSMINUS               0xe04e                     
           KEY_PAUSE               0xe046                     
           KEY_SCALE               0xe00b                     
           KEY_HANJA               0xe00d                     
         KEY_COMPOSE               0xe05d                     
            KEY_STOP               0xe068                     
           KEY_AGAIN               0xe005                     
           KEY_PROPS               0xe006                     
            KEY_UNDO               0xe007                     
           KEY_FRONT               0xe00c                     
            KEY_COPY               0xe078                     
            KEY_OPEN                 0x64                     
           KEY_PASTE                 0x65                     
            KEY_FIND               0xe041                     
             KEY_CUT               0xe03c                     
            KEY_HELP               0xe075                     
            KEY_MENU               0xe01e                     
            KEY_CALC               0xe021                     
           KEY_SETUP                 0x66                     
           KEY_SLEEP               0xe05f                     
          KEY_WAKEUP               0xe063                     
            KEY_FILE                 0x67                     
        KEY_SENDFILE                 0x68                     
      KEY_DELETEFILE                 0x69                     
            KEY_XFER               0xe013                     
           KEY_PROG1               0xe01f                     
           KEY_PROG2               0xe017                     
             KEY_WWW               0xe002                     
           KEY_MSDOS                 0x6a                     
      KEY_SCREENLOCK               0xe012                     
       KEY_DIRECTION                 0x6b                     
    KEY_CYCLEWINDOWS               0xe026                     
            KEY_MAIL               0xe06c                     
       KEY_BOOKMARKS               0xe066                     
        KEY_COMPUTER               0xe06b                     
            KEY_BACK               0xe06a                     
         KEY_FORWARD               0xe069                     
         KEY_CLOSECD               0xe023                     
         KEY_EJECTCD                 0x6c                     
    KEY_EJECTCLOSECD               0xe07d                     
        KEY_NEXTSONG               0xe019                     
       KEY_PLAYPAUSE               0xe022                     
    KEY_PREVIOUSSONG               0xe010                     
          KEY_STOPCD               0xe024                     
          KEY_RECORD               0xe031                     
          KEY_REWIND               0xe018                     
           KEY_PHONE                 0x63                     
             KEY_ISO                 0x70                     
          KEY_CONFIG               0xe001                     
        KEY_HOMEPAGE               0xe032                     
         KEY_REFRESH               0xe067                     
            KEY_EXIT                 0x71                     
            KEY_MOVE                 0x72                     
            KEY_EDIT               0xe008                     
        KEY_SCROLLUP                 0x75                     
      KEY_SCROLLDOWN               0xe00f                     
     KEY_KPLEFTPAREN               0xe076                     
    KEY_KPRIGHTPAREN               0xe07b                     
             KEY_NEW               0xe009                     
            KEY_REDO               0xe00a                     
             KEY_F13                 0x5d                     
             KEY_F14                 0x5e                     
             KEY_F15                 0x5f                     
             KEY_F16                 0x55                     
             KEY_F17               0xe003                     
             KEY_F18               0xe077                     
             KEY_F19               0xe004                     
             KEY_F20                 0x5a                     
             KEY_F21                 0x74                     
             KEY_F22               0xe079                     
             KEY_F23                 0x6d                     
             KEY_F24                 0x6f                     
                                   0xe015                     
                                   0xe016                     
                                   0xe01a                     
                                   0xe01b                     
                                   0xe027                     
          KEY_PLAYCD               0xe028                     
         KEY_PAUSECD               0xe029                     
           KEY_PROG3               0xe02b                     
           KEY_PROG4               0xe02c                     
       KEY_DASHBOARD               0xe02d                     
         KEY_SUSPEND               0xe025                     
           KEY_CLOSE               0xe02f                     
            KEY_PLAY               0xe033                     
     KEY_FASTFORWARD               0xe034                     
       KEY_BASSBOOST               0xe036                     
           KEY_PRINT               0xe039                     
              KEY_HP               0xe03a                     
          KEY_CAMERA               0xe03b                     
           KEY_SOUND               0xe03d                     
        KEY_QUESTION               0xe03e                     
           KEY_EMAIL               0xe03f                     
            KEY_CHAT               0xe040                     
          KEY_SEARCH               0xe065                     
         KEY_CONNECT               0xe042                     
         KEY_FINANCE               0xe043                     
           KEY_SPORT               0xe044                     
            KEY_SHOP               0xe045                     
        KEY_ALTERASE               0xe014                     
          KEY_CANCEL               0xe04a                     
  KEY_BRIGHTNESSDOWN               0xe04c                     
    KEY_BRIGHTNESSUP               0xe054                     
           KEY_MEDIA               0xe06d                     
 KEY_SWITCHVIDEOMODE               0xe056                     
  KEY_KBDILLUMTOGGLE               0xe057                     
    KEY_KBDILLUMDOWN               0xe058                     
      KEY_KBDILLUMUP               0xe059                     
            KEY_SEND               0xe05a                     
           KEY_REPLY               0xe064                     
     KEY_FORWARDMAIL               0xe00e                     
            KEY_SAVE               0xe055                     
       KEY_DOCUMENTS               0xe070                     
         KEY_BATTERY               0xe071                     
       KEY_BLUETOOTH               0xe072                     
            KEY_WLAN               0xe073                     
             KEY_UWB               0xe074                     

--+HP7ph2BbKc20aGI--
