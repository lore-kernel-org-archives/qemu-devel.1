Received: from eggs.gnu.org ([2001:4830:134:3::10]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmy9-0008CE-Hf
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmy6-0001fU-VH
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:58:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180718061027.10980-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <020f29d4-3fb4-e0b3-3756-e2065936fa42@amsat.org>
Date: Wed, 18 Jul 2018 10:58:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180718061027.10980-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] po: Don't include comments with
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Shopov <ash@kambanaria.org>, =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Stefan,

On 07/18/2018 03:10 AM, Stefan Weil wrote:
> Those comments change often when ui/gtk.c is changed and are not
> really useful.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Add also a new translation for German (still to be done for all other
> languages).

Do you mind moving this change in a different patch?

> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> CC'ing all translators because of the new string which still needs
> translations.
> 
> Regards
> Stefan
> 
>  po/Makefile    |  2 +-
>  po/bg.po       | 23 ++++-------------------
>  po/de_DE.po    | 23 ++++-------------------
>  po/fr_FR.po    | 23 ++++-------------------
>  po/hu.po       | 23 ++++-------------------
>  po/it.po       | 23 ++++-------------------
>  po/messages.po | 25 +++++--------------------
>  po/tr.po       | 23 ++++-------------------
>  po/zh_CN.po    | 23 ++++-------------------
>  9 files changed, 34 insertions(+), 154 deletions(-)
> 
> diff --git a/po/Makefile b/po/Makefile
> index cc630363de..e47e262ee6 100644
> --- a/po/Makefile
> +++ b/po/Makefile
> @@ -43,7 +43,7 @@ install: $(OBJS)
>  
>  $(PO_PATH)/messages.po: $(SRC_PATH)/ui/gtk.c
>  	$(call quiet-command, ( cd $(SRC_PATH) && \
> -          xgettext -o - --from-code=UTF-8 --foreign-user \
> +          xgettext -o - --from-code=UTF-8 --foreign-user --no-location \
>  	    --package-name=QEMU --package-version=$(VERSION) \
>  	    --msgid-bugs-address=qemu-devel@nongnu.org -k_ -C ui/gtk.c | \
>  	  sed -e s/CHARSET/UTF-8/) >$@,"GEN","$@")
> diff --git a/po/bg.po b/po/bg.po
> index 279d1b864a..3d8c353372 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -7,7 +7,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 2.6.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2016-06-09 15:54+0300\n"
>  "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
>  "Language-Team: Bulgarian <dict@ludost.net>\n"
> @@ -17,74 +17,59 @@ msgstr ""
>  "Content-Transfer-Encoding: 8bit\n"
>  "Plural-Forms: nplurals=2; plural=(n != 1);\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " — натиснете Ctrl+Alt+G, за да освободите фокуса"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [пауза]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Пауза"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "_Рестартиране"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Изключване"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr "_Спиране на програмата"
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr "На _цял екран"
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr "_Копиране"
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr "_Увеличаване"
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr "_Намаляване"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr "По_местване"
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Напас_ване"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Прихващане при посо_чване"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "Прихващане на _фокуса"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "Подпро_зорци"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr "Към самостоятелен подпрозорец"
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "_Машина"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Изглед"
> diff --git a/po/de_DE.po b/po/de_DE.po
> index de27fcf174..1411dc52f4 100644
> --- a/po/de_DE.po
> +++ b/po/de_DE.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 1.4.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2012-02-28 16:00+0100\n"
>  "Last-Translator: Kevin Wolf <kwolf@redhat.com>\n"
>  "Language-Team: Deutsch <de@li.org>\n"
> @@ -16,74 +16,59 @@ msgstr ""
>  "Content-Transfer-Encoding: 8bit\n"
>  "Plural-Forms: nplurals=2; plural=(n!=1);\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " - Strg+Alt+G drücken, um Eingabegeräte freizugeben"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [Angehalten]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Angehalten"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "_Reset"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Herunterfahren"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr "_Beenden"
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr "_Vollbild"
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr "_Kopieren"
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr "_Heranzoomen"
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr "_Wegzoomen"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr "_Einpassen"
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Auf _Fenstergröße skalieren"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Tastatur _automatisch einfangen"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "_Eingabegeräte einfangen"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "Reiter anzeigen"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr "Reiter abtrennen"
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr "Menü anzeigen"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  msgid "_Machine"
>  msgstr "_Maschine"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Ansicht"
> diff --git a/po/fr_FR.po b/po/fr_FR.po
> index 94f4a94f5c..25ad4c954a 100644
> --- a/po/fr_FR.po
> +++ b/po/fr_FR.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 1.4.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2014-07-28 23:25+0200\n"
>  "Last-Translator: Aurelien Jarno <aurelien@aurel32.net>\n"
>  "Language-Team: French <FR@li.org>\n"
> @@ -17,74 +17,59 @@ msgstr ""
>  "Plural-Forms: nplurals=2; plural=n != 1;\n"
>  "X-Generator: Lokalize 1.4\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr "- Appuyer sur Ctrl+Alt+G pour arrêter la capture"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [En pause]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Pause"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "_Réinitialiser"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Éteindre"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr "_Quitter"
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr "Mode _plein écran"
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr "_Copier"
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr "Zoom _avant"
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr "_Zoom arrière"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr "Zoom _idéal"
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Zoomer pour a_juster"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Capturer en _survolant"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "_Capturer les entrées"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "Montrer les _onglets"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr "_Détacher l'onglet"
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "_Machine"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Vue"
> diff --git a/po/hu.po b/po/hu.po
> index 86f78e92b9..a82d9ec230 100644
> --- a/po/hu.po
> +++ b/po/hu.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 1.4.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2013-05-06 20:42+0200\n"
>  "Last-Translator: Ákos Kovács <akoskovacs@gmx.com>\n"
>  "Language-Team: Hungarian <hu@li.org>\n"
> @@ -15,77 +15,62 @@ msgstr ""
>  "Content-Type: text/plain; charset=UTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " - Nyomj Ctrl+Alt+G-t a bemeneti eszközök elengedéséhez"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [Megállítva]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Megállítás"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "Új_raindítás"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Leállítás"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr ""
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr ""
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr ""
>  
> -#: ui/gtk.c:2048
>  #, fuzzy
>  msgid "Zoom _In"
>  msgstr "Ablakmérethez _igazítás"
>  
> -#: ui/gtk.c:2055
>  #, fuzzy
>  msgid "Zoom _Out"
>  msgstr "Ablakmérethez _igazítás"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr ""
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Ablakmérethez _igazítás"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Automatikus _elfogás"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "_Bemeneti eszközök megragadása"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "_Fülek megjelenítése"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr ""
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "_Gép"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Nézet"
>  
> diff --git a/po/it.po b/po/it.po
> index bfae84e797..c6d9517207 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 1.4.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2014-07-29 08:25+0200\n"
>  "Last-Translator: Paolo Bonzini <pbonzini@redhat.com>\n"
>  "Language-Team: Italian <it@li.org>\n"
> @@ -16,74 +16,59 @@ msgstr ""
>  "Content-Transfer-Encoding: 8bit\n"
>  "Plural-Forms: nplurals=2; plural=n != 1;\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " - Premere Ctrl+Alt+G per rilasciare l'input"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [Pausa]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Pausa"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "_Reset"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Spegni"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr "_Esci"
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr "A t_utto schermo"
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr "_Copia"
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr "_Aumenta zoom"
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr "_Riduci zoom"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr "A_nnulla zoom"
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Adatta alla _finestra"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Cattura _automatica input"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "_Cattura input"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "Mostra _tab"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr "_Sposta in una nuova finestra"
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "_Macchina virtuale"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Visualizza"
> diff --git a/po/messages.po b/po/messages.po
> index e0a98c16a9..065bd459a0 100644
> --- a/po/messages.po
> +++ b/po/messages.po
> @@ -5,9 +5,9 @@
>  #, fuzzy
>  msgid ""
>  msgstr ""
> -"Project-Id-Version: QEMU 2.7.93\n"
> +"Project-Id-Version: QEMU 2.12.91\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
>  "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
>  "Language-Team: LANGUAGE <LL@li.org>\n"
> @@ -16,74 +16,59 @@ msgstr ""
>  "Content-Type: text/plain; charset=UTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr ""
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr ""
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr ""
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr ""
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr ""
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr ""
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr ""
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr ""
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr ""
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr ""
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr ""
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr ""
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr ""
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr ""
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr ""
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr ""
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr ""
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr ""
> diff --git a/po/tr.po b/po/tr.po
> index af34b52d52..632c7f3851 100644
> --- a/po/tr.po
> +++ b/po/tr.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 1.4.50\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2013-04-22 18:35+0300\n"
>  "Last-Translator: Ozan Çağlayan <ozancag@gmail.com>\n"
>  "Language-Team: Türkçe <>\n"
> @@ -17,76 +17,61 @@ msgstr ""
>  "Plural-Forms: nplurals=1; plural=0;\n"
>  "X-Generator: Gtranslator 2.91.6\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " - Yakalamayı durdurmak için Ctrl+Alt+G tuşlarına basın"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [Duraklatıldı]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "_Duraklat"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "_Sıfırla"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "_Kapat"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr ""
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr ""
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr ""
>  
> -#: ui/gtk.c:2048
>  #, fuzzy
>  msgid "Zoom _In"
>  msgstr "Yakınlaş ve Sığ_dır"
>  
> -#: ui/gtk.c:2055
>  #, fuzzy
>  msgid "Zoom _Out"
>  msgstr "Yakınlaş ve Sığ_dır"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr ""
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "Yakınlaş ve Sığ_dır"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "Ü_zerindeyken Yakala"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "Girdiyi _Yakala"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "Se_kmeleri Göster"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr ""
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "_Makine"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "_Görüntüle"
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> index d20b6c6981..b25e8e3c02 100644
> --- a/po/zh_CN.po
> +++ b/po/zh_CN.po
> @@ -6,7 +6,7 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: QEMU 2.2\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2016-12-13 21:46+0000\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
>  "PO-Revision-Date: 2014-07-31 10:00+0800\n"
>  "Last-Translator: Fam Zheng <famz@redhat.com>\n"
>  "Language-Team: Chinese <zh@li.org>\n"
> @@ -17,74 +17,59 @@ msgstr ""
>  "Plural-Forms: nplurals=2; plural=n != 1;\n"
>  "X-Generator: Lokalize 1.4\n"
>  
> -#: ui/gtk.c:275
>  msgid " - Press Ctrl+Alt+G to release grab"
>  msgstr " - 按下 Ctrl+Alt+G 取消捕获"
>  
> -#: ui/gtk.c:279
>  msgid " [Paused]"
>  msgstr " [已暂停]"
>  
> -#: ui/gtk.c:1922
>  msgid "_Pause"
>  msgstr "暂停(_P)"
>  
> -#: ui/gtk.c:1928
>  msgid "_Reset"
>  msgstr "重置(_R)"
>  
> -#: ui/gtk.c:1931
>  msgid "Power _Down"
>  msgstr "关闭电源(_D)"
>  
> -#: ui/gtk.c:1937
>  msgid "_Quit"
>  msgstr "退出(_Q)"
>  
> -#: ui/gtk.c:2029
>  msgid "_Fullscreen"
>  msgstr "全屏(_F)"
>  
> -#: ui/gtk.c:2032
>  msgid "_Copy"
>  msgstr "复制(_C)"
>  
> -#: ui/gtk.c:2048
>  msgid "Zoom _In"
>  msgstr "放大(_I)"
>  
> -#: ui/gtk.c:2055
>  msgid "Zoom _Out"
>  msgstr "缩小(_O)"
>  
> -#: ui/gtk.c:2062
>  msgid "Best _Fit"
>  msgstr "最合适大小(_F)"
>  
> -#: ui/gtk.c:2069
>  msgid "Zoom To _Fit"
>  msgstr "缩放以适应大小(_F)"
>  
> -#: ui/gtk.c:2075
>  msgid "Grab On _Hover"
>  msgstr "鼠标经过时捕获(_H)"
>  
> -#: ui/gtk.c:2078
>  msgid "_Grab Input"
>  msgstr "捕获输入(_G)"
>  
> -#: ui/gtk.c:2107
>  msgid "Show _Tabs"
>  msgstr "显示标签页(_T)"
>  
> -#: ui/gtk.c:2110
>  msgid "Detach Tab"
>  msgstr "分离标签页"
>  
> -#: ui/gtk.c:2122
> +msgid "Show Menubar"
> +msgstr ""
> +
>  msgid "_Machine"
>  msgstr "虚拟机(_M)"
>  
> -#: ui/gtk.c:2127
>  msgid "_View"
>  msgstr "视图(_V)"
> 
