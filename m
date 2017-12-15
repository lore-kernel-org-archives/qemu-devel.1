Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1ePwCk-0005Co-Jw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 15:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1ePwCj-0005m6-75
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 15:03:34 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:38277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1ePwCj-0005la-32
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 15:03:33 -0500
Received: by mail-qt0-x22d.google.com with SMTP id d4so13523766qtj.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 12:03:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215135738.GF11724@redhat.com>
References: <CABMrAhLV6LLwBR70-P4EnekWHKD4AkaatzxQwuxtOnNYQ3MEqQ@mail.gmail.com>
	<20171215135738.GF11724@redhat.com>
From: Miika S <miika9764@gmail.com>
Date: Fri, 15 Dec 2017 22:03:31 +0200
Message-ID: <CABMrAhLGAm60AgMjbaKSd3k=oX7J6DVO-DwwW04RE75mEWqhCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Key code conflict in keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Ok, I don't know if there is a separate place where to send patches
for keycodemapdb but I will put it in this reply. I will send a new
set of patches for the QEMU changes that were in the first mail
(hopefully in a better format than this one) and also a fix for mouse
wheel event being sent twice.
------------------------------------------------------------------------------
>From 506f0bf52b9743e19a65be83be8adf4782edd21b Mon Sep 17 00:00:00 2001
From: Miika S <miika9764@gmail.com>
Date: Fri, 15 Dec 2017 21:50:23 +0200
Subject: [PATCH 1/1] Add missing QKeyCode values for JIS keyboards

The AT set1 code for KEY_ISO is removed because it conflicts with
KEY_KATAKANAHIRAGANA.

Signed-off-by: Miika S <miika9764@gmail.com>
---
 data/keymaps.csv | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/data/keymaps.csv b/data/keymaps.csv
index 0ef2ec1..bc2376c 100644
--- a/data/keymaps.csv
+++ b/data/keymaps.csv
@@ -154,9 +154,9 @@
KEY_KATAKANA,90,JIS_Kana,0x68,0x78,0x63,,146,VK_KANA,0x15,,,,,Lang3,KATA,,,
 KEY_HIRAGANA,91,,,0x77,0x62,0x87,147,,,,,,,Hiragana,HIRA,hiragana,,
 KEY_HIRAGANA,91,,,0x77,0x62,0x87,147,,,,,,,Lang4,HIRA,hiragana,,
 KEY_HENKAN,92,,,0x79,0x64,0x86,138,,,,,,,Convert,HENK,henkan,,
-KEY_KATAKANAHIRAGANA,93,,,0x70,0x13,0x87,136,,,0xc8,0xc8,,,KanaMode,HKTG,,,
-KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,NFER,,,
-KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,MUHE,,,
+KEY_KATAKANAHIRAGANA,93,,,0x70,0x13,0x87,136,,,0xc8,0xc8,,,KanaMode,HKTG,katakanahiragana,,
+KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,NFER,muhenkan,,
+KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,MUHE,muhenkan,,
 KEY_KPJPCOMMA,95,JIS_KeypadComma,0x5f,0x5c,0x27,,140,,,,,XK_KP_Separator,0xffac,,KPSP,,,
 KEY_KPJPCOMMA,95,JIS_KeypadComma,0x5f,0x5c,0x27,,140,,,,,XK_KP_Separator,0xffac,,JPCM,,,
 KEY_KPENTER,96,ANSI_KeypadEnter,0x4c,0xe01c,0xe05a,0x79,88,,,0x64,0x64,XK_KP_Enter,0xff8d,NumpadEnter,KPEN,kp_enter,0x5a,0x4c
@@ -246,7 +246,7 @@
KEY_STOPCD,166,,,0xe024,0xe03b,0x98,233,VK_MEDIA_STOP,0xb2,,,,,MediaStop,I174,au
 KEY_RECORD,167,,,0xe031,,0x9e,,,,,,,,,I175,,,
 KEY_REWIND,168,,,0xe018,,0x9f,,,,,,,,,I176,,,
 KEY_PHONE,169,,,0x63,,,,,,,,,,,I177,,,
-KEY_ISO,170,ISO_Section,0xa,0x70,,,,,,,,,,,I178,,,
+KEY_ISO,170,ISO_Section,0xa,,,,,,,,,,,,I178,,,
 KEY_CONFIG,171,,,0xe001,,,,,,,,,,,I179,,,
 KEY_HOMEPAGE,172,,,0xe032,0xe03a,0x97,,VK_BROWSER_HOME,0xac,,,,,BrowserHome,I180,ac_home,,
 KEY_REFRESH,173,,,0xe067,0xe020,,250,VK_BROWSER_REFRESH,0xa8,,,,,BrowserRefresh,I181,ac_refresh,,
-- 
2.15.1


On Fri, Dec 15, 2017 at 3:57 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Fri, Dec 15, 2017 at 03:51:19PM +0200, Miika S wrote:
>> Hi
>>
>> I tried to add JIS keyboard support to virtio-input-hid but ran
>> into a problem with keys that have the "Linux Name" KEY_ISO and
>> KEY_KATAKANAHIRAGANA. The problem appears to be that they have
>> the same "AT set1 keycode" 0x70. I worked around it by removing
>> KEY_ISO from keycodemapdb and got the keys working, but that
>> doesn't work for the rest of QEMU. Is it intended that the keys
>> have the same "AT set1 keycode"?
>
> It is probably a misake
>
>
>> @@ -246,7 +246,6 @@
>> KEY_STOPCD,166,,,0xe024,0xe03b,0x98,233,VK_MEDIA_STOP,0xb2,,,,,MediaStop,I174,au
>>  KEY_RECORD,167,,,0xe031,,0x9e,,,,,,,,,I175,,,
>>  KEY_REWIND,168,,,0xe018,,0x9f,,,,,,,,,I176,,,
>>  KEY_PHONE,169,,,0x63,,,,,,,,,,,I177,,,
>> -KEY_ISO,170,ISO_Section,0xa,0x70,,,,,,,,,,,I178,,,
>
> Instead of deleteing this line entirely, the right fix is probably to just
> blank out the 0x70 value here.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
